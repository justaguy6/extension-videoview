package extension.videoview;

#if android
import lime.system.JNI;
#end

class VideoView {
    public static var onCompletion:Void->Void = null;
    public static var onPrepared:Void->Void = null;

    private static var callback:CallBack;

    public static function playVideo(path:String = null):Void {
        #if android
        if (callback == null) {
            callback = new CallBack();
            JNI.createStaticMethod("extensions/videoview/VideoViewExtension", "setCallback", "(Lorg/haxe/lime/HaxeObject;)V")(callback);
        }
        JNI.createStaticMethod("extensions/videoview/VideoViewExtension", "playVideo", "(Ljava/lang/String;)V")(path);
        #end
    }
}

class CallBack {
    public function new() {}

    public function onCompletion() {
        if (VideoView.onCompletion != null) {
            VideoView.onCompletion();
        }
    }

    public function onPrepared() {
        if (VideoView.onPrepared != null) {
            VideoView.onPrepared();
        }
    }
}
