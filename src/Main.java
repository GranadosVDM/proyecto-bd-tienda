import java.sql.Connection;
import java.sql.CallableStatement;

public class Main {
    public static void main(String[] args) {
        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            try {
                CallableStatement cs = conexion.prepareCall("{ ? = call FN_CANTIDAD_FACTURAS_CLIENTE(?) }");
                cs.registerOutParameter(1, java.sql.Types.NUMERIC);
                cs.setInt(2, 1);

                cs.execute();

                int cantidad = cs.getInt(1);
                System.out.println("CANTIDAD DE FACTURAS DEL CLIENTE 1: " + cantidad);

            } catch (Exception e) {
                System.out.println("Error al ejecutar la función:");
                e.printStackTrace();
            }
        } else {
            System.out.println("No se pudo establecer la conexión.");
        }
    }
}