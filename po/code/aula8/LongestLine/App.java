import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class App {
    public static void main(String[] args) {
        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(args[0]));

            String line = bufferedReader.readLine();
            String longest = "";

            while (line != null) {
                if (line.length() > longest.length()) {
                    longest = line;
                }

                line = bufferedReader.readLine();
            }

            bufferedReader.close();

            // eh capaz que esteja incompleto

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}