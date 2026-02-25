import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:pro_image_editor/shared/widgets/layer/interaction_helper/layer_interaction_button.dart';

// to use this class
// final ImageEdit imageEdit = ImageEdit(
//   editorFactory: (file, configs) => ProImageEditor.file(file, configs: configs),
// );

class UChatEditImage {
  final ProImageEditor Function(dynamic file, ProImageEditorConfigs configs, ProImageEditorCallbacks callbacks)
      editorFactory;
  final Widget? cancelIcon;
  final Widget? doneIcon;
  final Widget? undoIcon;
  final Widget? redoIcon;

  UChatEditImage({
    required this.editorFactory,
    this.cancelIcon,
    this.doneIcon,
    this.undoIcon,
    this.redoIcon,
  });

  Future<void> handleEditImage({
    required dynamic file,
    required BuildContext context,
    required ImageEditingCompleteCallback onEditComplete,
  }) async {
    await Get.to(
      () => Scaffold(
        backgroundColor: Colors.black,
        body: _buildChild(
          file: file,
          onEditComplete: onEditComplete,
        ),
      ),
    );
  }

  Widget _buildChild({
    required dynamic file,
    required ImageEditingCompleteCallback onEditComplete,
  }) {
    return editorFactory(
      file,
      ProImageEditorConfigs(
        designMode: platformDesignMode,
        mainEditor: MainEditorConfigs(
          enableCloseButton: true,
          widgets: MainEditorWidgets(
            appBar: (editor, state) => ReactiveAppbar(
              builder: (c) {
                return _buildAppBar(editor);
              },
              stream: state,
            ),
          ),
        ),
        imageGeneration: const ImageGenerationConfigs(
          processorConfigs: ProcessorConfigs(processorMode: ProcessorMode.auto),
        ),
        layerInteraction: LayerInteractionConfigs(
          widgets: LayerInteractionWidgets(children: _buildLayerInteractionWidgets()),
          selectable: LayerInteractionSelectable.enabled,
          initialSelected: true,
          icons: const LayerInteractionIcons(
            remove: Icons.clear,
            edit: Icons.edit_outlined,
            rotateScale: Icons.sync,
          ),
          style: const LayerInteractionStyle(
            buttonRadius: 10,
            strokeWidth: 1.2,
            borderElementWidth: 7,
            borderElementSpace: 5,
            borderColor: Colors.blue,
            borderStyle: LayerInteractionBorderStyle.solid,
          ),
        ),
        i18n: const I18n(
          layerInteraction: I18nLayerInteraction(
            remove: 'Remove',
            edit: 'Edit',
            rotateScale: 'Rotate and Scale',
          ),
        ),
      ),
      ProImageEditorCallbacks(
        onImageEditingStarted: null,
        onImageEditingComplete: onEditComplete,
        mainEditorCallbacks: const MainEditorCallbacks(
          helperLines: HelperLinesCallbacks(),
        ),
      ),
    );
  }

  List<ReactiveWidget<Widget> Function(Stream<void>, Layer, LayerItemInteractions)>? _buildLayerInteractionWidgets() {
    return [
      (rebuildStream, layer, interactions) => ReactiveWidget(
            stream: rebuildStream,
            builder: (_) => layer.isPaintLayer || layer.isTextLayer
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: Transform.rotate(
                      angle: -layer.rotation,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: interactions.edit,
                          child: Tooltip(
                            message: 'Edit',
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.edit, color: Colors.black, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      (rebuildStream, layer, interactions) => ReactiveWidget(
            stream: rebuildStream,
            builder: (_) => Positioned(
              top: 0,
              right: 0,
              child: LayerInteractionButton(
                rotation: -layer.rotation,
                onTap: interactions.remove,
                buttonRadius: 10,
                cursor: SystemMouseCursors.click,
                icon: Icons.clear,
                tooltip: 'Remove',
                color: Colors.black,
                background: Colors.white,
              ),
            ),
          ),
      (rebuildStream, layer, interactions) => ReactiveWidget(
            stream: rebuildStream,
            builder: (_) => Positioned(
              bottom: 0,
              right: 0,
              child: LayerInteractionButton(
                rotation: -layer.rotation,
                onScaleRotateDown: interactions.scaleRotateDown,
                onScaleRotateUp: interactions.scaleRotateUp,
                buttonRadius: 10,
                cursor: SystemMouseCursors.click,
                icon: Icons.sync,
                tooltip: 'Rotate and Scale',
                color: Colors.black,
                background: Colors.white,
              ),
            ),
          ),
      (rebuildStream, layer, interactions) => ReactiveWidget(
            stream: rebuildStream,
            builder: (_) => Positioned(
              bottom: 0,
              left: 0,
              child: LayerInteractionButton(
                rotation: -layer.rotation,
                onTap: () {
                  interactions.duplicated();
                  interactions.remove();
                },
                buttonRadius: 10,
                cursor: SystemMouseCursors.click,
                icon: Icons.layers,
                color: Colors.black,
                background: Colors.white,
                tooltip: 'Make to top',
              ),
            ),
          ),
    ];
  }

  AppBar _buildAppBar(ProImageEditorState editor) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          tooltip: 'Cancel',
          padding: const EdgeInsets.symmetric(horizontal: 8),
          icon: cancelIcon ?? const Icon(Icons.close),
          onPressed: editor.closeEditor,
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Undo',
          padding: const EdgeInsets.symmetric(horizontal: 8),
          icon: undoIcon ??
              Icon(
                Icons.undo,
                color: editor.canUndo == true ? Colors.white : Colors.white.withAlpha(80),
              ),
          onPressed: editor.undoAction,
        ),
        IconButton(
          tooltip: 'Redo',
          padding: const EdgeInsets.symmetric(horizontal: 8),
          icon: redoIcon ??
              Icon(
                Icons.redo,
                color: editor.canRedo == true ? Colors.white : Colors.white.withAlpha(80),
              ),
          onPressed: editor.redoAction,
        ),
        SizedBox(width: 8.spMin),
        GestureDetector(
          onTap: editor.doneEditing,
          child: doneIcon ??
              const Icon(
                Icons.done,
                color: Colors.white,
              ),
        ),
        SizedBox(width: 8.spMin),
      ],
    );
  }
}
