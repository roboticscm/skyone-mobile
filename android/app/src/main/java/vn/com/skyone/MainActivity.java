package vn.com.skyone;

import android.content.Intent;

import io.flutter.embedding.android.FlutterActivity;
import com.zing.zalo.zalosdk.oauth.ZaloSDK;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        ZaloSDK.Instance.onActivityResult(this, requestCode, resultCode, data);
    }
}
