/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import com.mycompany.dlvery.datalayer.connectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;

/**
 *
 * @author atulv
 */
public class inventoryQueries {
    
    DataSource dataSource;
    static Connection connection;
    public inventoryQueries(){
        try{
            dataSource = connectionPool.getDataSource();
        connection = dataSource.getConnection();
        }catch(Exception e){
            
        }
    }
   
    
    public static ResultSet getAllInventory() throws SQLException{
       
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table");
        return statement.executeQuery();
       
    }
    
}
