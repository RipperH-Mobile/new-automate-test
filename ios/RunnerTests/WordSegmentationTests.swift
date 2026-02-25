import XCTest
import NaturalLanguage

class WordSegmentationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Setup code here
    }
    
    override func tearDown() {
        // Tear down code here
        super.tearDown()
    }
    
    func wordSegmentation(_ text: String, language: NLLanguage) -> [String] {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.setLanguage(language)
        tokenizer.string = text

        // Get the ranges of all the words
        let tokenRanges = tokenizer.tokens(for: text.startIndex..<text.endIndex)

        // Map the ranges to the actual words and return as a list
        return tokenRanges.map { String(text[$0]) }
    }
    
    // MARK: - English Tests
    
    func testEnglishWordSegmentation() {
        // Test English text segmentation
        let englishText = "Hello world! This is a test."
        let expectedSegments = ["Hello", "world", "This", "is", "a", "test"]
        
        let segments = wordSegmentation(englishText, language: .english)
        
        // Compare results (excluding punctuation which is filtered out)
        XCTAssertEqual(segments, expectedSegments)
    }
    
    func testEnglishCompoundWords() {
        // Test English text with compound words
        let englishText = "Bookstore database management software"
        let expectedSegments = ["Bookstore", "database", "management", "software"]
        
        let segments = wordSegmentation(englishText, language: .english)
        
        XCTAssertEqual(segments, expectedSegments)
    }
    
    func testEnglishWithNumbers() {
        // Test English text with numbers
        let englishText = "I have 3 apples and 5 oranges"
        let expectedSegments = ["I", "have", "3", "apples", "and", "5", "oranges"]
        
        let segments = wordSegmentation(englishText, language: .english)
        
        XCTAssertEqual(segments, expectedSegments)
    }
    
    // MARK: - Thai Tests
    
    func testThaiBasicSentence() {
        // Test Thai text segmentation (Thai doesn't use spaces between words)
        let thaiText = "สวัสดีครับทุกคน"  // Hello everyone
        
        let segments = wordSegmentation(thaiText, language: .thai)
        let expectedSegments =  ["สวัสดี", "ครับ", "ทุกคน"]
        // Thai segmentation should properly identify words
        // Expected result might be: ["สวัสดี", "ครับ", "ทุก", "คน"]
        // But actual results can vary with NLTokenizer, so we'll check some basics
        XCTAssertEqual(segments, expectedSegments)
        XCTAssertTrue(segments.count >= 2)
        XCTAssertNotEqual(segments.count, thaiText.count) // Should not be character by character
    }
    
    func testThaiWithSpaces() {
        // Test Thai text with spaces and punctuation
        let thaiText = "ผมชอบกิน ข้าวผัดกะเพรา!"  // I like eating basil fried rice!
        
        let segments = wordSegmentation(thaiText, language: .thai)
        let expectedSegments =  ["ผม", "ชอบ", "กิน", "ข้าวผัดกะเพรา"]
        
        XCTAssertEqual(segments, expectedSegments)
        // Should segment words correctly despite the space
        // The space shouldn't be treated as a token
        XCTAssertFalse(segments.contains(" "))
        XCTAssertTrue(segments.count >= 3)
    }
    
    func testThaiWithSpaces2() {
        // Test Thai text with spaces and punctuation
        let thaiText = "โคลงเรือทำให้เรือโคลง"  // I like eating basil fried rice!
        
        let segments = wordSegmentation(thaiText, language: .thai)
        let expectedSegments =  ["โค", "ลงเรือ", "ทำให้", "เรือ", "โคลง"]
        
        XCTAssertEqual(segments, expectedSegments)
        // Should segment words correctly despite the space
        // The space shouldn't be treated as a token
        XCTAssertFalse(segments.contains(" "))
        XCTAssertTrue(segments.count >= 3)
    }
    
    func testThaiWithSpaces3() {
        // Test Thai text with spaces and punctuation
        let thaiText = "สาวตากลมนั่งตากลม"  // I like eating basil fried rice!
        
        let segments = wordSegmentation(thaiText, language: .thai)
        let expectedSegments =  ["สาว", "ตากลม", "นั่ง", "ตากลม"]
        
        XCTAssertEqual(segments, expectedSegments)
        // Should segment words correctly despite the space
        // The space shouldn't be treated as a token
        XCTAssertFalse(segments.contains(" "))
        XCTAssertTrue(segments.count >= 3)
    }
    
    func testThaiWithSpaces4() {
        // Test Thai text with spaces and punctuation
        let thaiText = "รรรรรรร"  // I like eating basil fried rice!
        
        let segments = wordSegmentation(thaiText, language: .thai)
        let expectedSegments =  ["รรรรรรร"]
        
        XCTAssertEqual(segments, expectedSegments)
        // Should segment words correctly despite the space
        // The space shouldn't be treated as a token
        XCTAssertFalse(segments.contains(" "))
        XCTAssertTrue(segments.count >= 3)
    }
    
    func testThaiWithEnglishMixed() {
        // Test mixing Thai and English
        let mixedText = "ผมชอบ iPhone มาก"  // I really like iPhone
        
        let segments = wordSegmentation(mixedText, language: .thai)
        let expectedSegments =  ["ผม", "ชอบ", "iPhone", "มาก"]
        XCTAssertEqual(segments, expectedSegments)
        // Should identify "iPhone" as a separate token in Thai context
        XCTAssertTrue(segments.contains("iPhone"))
    }
    
    // MARK: - Edge Cases
    
    func testEmptyString() {
        // Test with empty string
        let emptyText = ""
        let segments = wordSegmentation(emptyText, language: .english)
        
        XCTAssertEqual(segments, [])
        
        // Same for Thai
        let thaiSegments = wordSegmentation(emptyText, language: .thai)
        XCTAssertEqual(thaiSegments, [])
    }
    
    func testSingleWordString() {
        // Test with a single word
        let englishSingleWord = "Hello"
        let segments = wordSegmentation(englishSingleWord, language: .english)
        
        XCTAssertEqual(segments, ["Hello"])
        
        // Same for Thai
        let thaiSingleWord = "สวัสดี"
        let thaiSegments = wordSegmentation(thaiSingleWord, language: .thai)
        XCTAssertEqual(thaiSegments, ["สวัสดี"])
    }
    
    // MARK: - Language Detection Tests
    
    func testLanguageCodesFromStrings() {
        let englishCode = "en"
        let thaiCode = "th"
        
        // Test creating languages from string codes
        if let englishLang = NLLanguage.init(rawValue: englishCode) as? NLLanguage,
           let thaiLang = NLLanguage.init(rawValue: thaiCode) as? NLLanguage {
            
            let englishText = "Hello world"
            let thaiText = "สวัสดีครับ"
            
            let englishSegments = wordSegmentation(englishText, language: englishLang)
            let thaiSegments = wordSegmentation(thaiText, language: thaiLang)
            
            XCTAssertEqual(englishSegments, ["Hello", "world"])
            XCTAssertEqual(thaiSegments, ["สวัสดี", "ครับ"])
            XCTAssertTrue(thaiSegments.count >= 1)
        } else {
            XCTFail("Failed to create language from string codes")
        }
    }
}
