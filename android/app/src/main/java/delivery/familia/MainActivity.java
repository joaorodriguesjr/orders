package delivery.familia;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.dantsu.escposprinter.EscPosPrinter;
import com.dantsu.escposprinter.connection.bluetooth.BluetoothConnection;
import com.dantsu.escposprinter.connection.bluetooth.BluetoothPrintersConnections;
import com.dantsu.escposprinter.EscPosCharsetEncoding;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_NAME = "delivery.printer";

    private EscPosPrinter printer;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_NAME);
        connectPrinter();

        methodChannel.setMethodCallHandler((call, result) -> {
            if (call.method.equals("print")) {
                try {
                    printer.printFormattedText(call.argument("text"), 7.0f);
                } catch (Exception e) {
                    printer = null;
                }
            } else {
                result.notImplemented();
            }
        });
    }

    private void connectPrinter() {
        try {
            BluetoothConnection connection = BluetoothPrintersConnections.selectFirstPaired();
            printer = new EscPosPrinter(connection, 203, 48f, 32);
        } catch (Exception e) {
            printer = null;
        }
    }
}
