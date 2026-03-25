import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    public static Connection conectar() {
        Connection conexion = null;

        String url = "jdbc:oracle:thin:@basededatosfidelitas_low";
        String usuario = "ADMIN";
        String contraseña = "Mani032599-PeriodoHumilde";

        try {
            System.setProperty("oracle.net.tns_admin", "C:\\Users\\GranadosVDM\\Desktop\\Wallet_BasedeDatosFidelitas");

            Class.forName("oracle.jdbc.OracleDriver");
            conexion = DriverManager.getConnection(url, usuario, contraseña);
            System.out.println("Conexión exitosa a Oracle.");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: no se encontró el driver JDBC de Oracle.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error al conectar con la base de datos.");
            e.printStackTrace();
        }

        return conexion;
    }
}