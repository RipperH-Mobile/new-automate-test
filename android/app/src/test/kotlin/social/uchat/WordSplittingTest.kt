package social.uchat

import org.junit.Test
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import java.text.BreakIterator
import java.util.Locale

// ./gradlew :app:testDevDebugUnitTest --tests "social.uchat.WordSplittingTest"
class WordSplittingTest {

    @Test
    fun testThaiWordSegmentation() {
        // Thai text example: "สวัสดีครับ ผมชื่อนายรักภาษาไทย"
        val thaiText = "สวัสดีครับ ผมชื่อนายรักภาษาไทย"
        val thaiLocale = Locale("th", "TH")

        val result = wordSegmentation(thaiText, thaiLocale)

        // Expected segmented words
        val expected = listOf("สวัสดี", "ครับ", " ", "ผม", "ชื่อ", "นาย", "รัก", "ภาษา", "ไทย")
        assertEquals(expected, result)

        // Alternatively, if exact segmentation is implementation-dependent,
        // just check that segmentation happened
        assertTrue(result.size > 1)
        assertTrue(result.contains("สวัสดี"))
        assertTrue(result.contains("ครับ"))
    }

    @Test
    fun testThaiWordSegmentation1() {
        // Thai text example: "สวัสดีครับ ผมชื่อนายรักภาษาไทย"
        val thaiText = "ผมชอบกิน ข้าวผัดกะเพรา!"
        val thaiLocale = Locale("th", "TH")

        val result = wordSegmentation(thaiText, thaiLocale)

        // Expected segmented words
        val expected = listOf("ผม", "ชอบ", "กิน", " ", "ข้าว", "ผัด", "กะเพรา", "!")
        assertEquals(expected, result)
    }

    @Test
    fun testThaiWordSegmentation2() {
        // Thai text example: "สวัสดีครับ ผมชื่อนายรักภาษาไทย"
        val thaiText = "โคลงเรือทำให้เรือโคลง"
        val thaiLocale = Locale("th", "TH")

        val result = wordSegmentation(thaiText, thaiLocale)

        // Expected segmented words
        val expected = listOf(
            "โค",
            "ลงเรือ",
            "ทำให้",
            "เรือ",
            "โคลง"
        ) // but was:<[โคลง, เรือ, ทำให้, เรือ, โคลง]>
        assertEquals(expected, result)
    }

    @Test
    fun testThaiWordSegmentation3() {
        // Thai text example: "สวัสดีครับ ผมชื่อนายรักภาษาไทย"
        val thaiText = "สาวตากลมนั่งตากลม"
        val thaiLocale = Locale("th", "TH")

        val result = wordSegmentation(thaiText, thaiLocale)

        // Expected segmented words
        val expected =
            listOf("สาว", "ตากลม", "นั่ง", "ตากลม") // but was:<[สาว, ตาก, ลม, นั่ง, ตาก, ลม]>
        assertEquals(expected, result)
    }

    @Test
    fun testEnglishWordSegmentation() {
        val englishText = "Hello world, this is a test."
        val englishLocale = Locale("en", "US")

        val result = wordSegmentation(englishText, englishLocale)

        // Expected segmented words (may vary based on exact implementation)
        val expected =
            listOf("Hello", " ", "world", ",", " ", "this", " ", "is", " ", "a", " ", "test", ".")
        assertEquals(expected, result)

        // Or check that we have the expected words
        assertTrue(result.contains("Hello"))
        assertTrue(result.contains("world"))
        assertTrue(result.contains("test"))
    }

    @Test
    fun testEmptyString() {
        val emptyText = ""
        val result = wordSegmentation(emptyText)

        assertTrue(result.isEmpty())
    }

    // You'll need to add the wordSegmentation function here to make the tests work
    // This should be the same as in your main code

    private fun wordSegmentation(txt: String, locale: Locale = Locale("th", "TH")): List<String> {
        val boundary = BreakIterator.getWordInstance(locale)
        boundary.setText(txt)
        val words = mutableListOf<String>()
        var start = boundary.first()
        var end = boundary.next()
        while (end != BreakIterator.DONE) {
            words.add(txt.substring(start, end))
            start = end
            end = boundary.next()
        }
        return words
    }
}