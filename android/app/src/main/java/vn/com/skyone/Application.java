package vn.com.skyone;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
// import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import com.zing.zalo.zalosdk.oauth.ZaloSDKApplication;
import io.flutter.view.FlutterMain;
import android.app.Activity;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
    private Activity mCurrentActivity = null;

    @Override
    public void onCreate() {
        super.onCreate();
        ZaloSDKApplication.wrap(this);
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        FlutterMain.startInitialization(this);
    }



    public Activity getCurrentActivity() {
        return mCurrentActivity;
    }

    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
    }
}
