package delivery.familia;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.dantsu.escposprinter.EscPosPrinter;
import com.dantsu.escposprinter.connection.bluetooth.BluetoothConnection;
import com.dantsu.escposprinter.connection.bluetooth.BluetoothPrintersConnections;
import com.dantsu.escposprinter.EscPosCharsetEncoding;

import java.util.logging.Level;
import java.util.logging.Logger;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_NAME = "delivery.printer";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_NAME);
        Logger logger = Logger.getAnonymousLogger();

        methodChannel.setMethodCallHandler((call, result) -> {
            if (call.method.equals("print")) {
                try {
                    BluetoothConnection connection = BluetoothPrintersConnections.selectFirstPaired();
                    EscPosPrinter printer = new EscPosPrinter(connection, 203, 48f, 32, new EscPosCharsetEncoding("IBM860", 3));
                    printer.printFormattedText(call.argument("text"), 7.0f);
                    printer.disconnectPrinter();
                } catch (Exception e) {
                    logger.log(Level.SEVERE, "An exception was thrown", e);
                }
            } else {
                result.notImplemented();
            }
        });
    }
}
