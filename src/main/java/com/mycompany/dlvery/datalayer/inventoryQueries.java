/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


package com.mycompany.dlvery.datalayer;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;

/**
 *
 * @author atulv
 */
public class inventoryQueries implements Serializable{
    
    DataSource dataSource;
    static Connection connection;
    public inventoryQueries(){
        try{
            dataSource = connectionPool.getDataSource();
        connection = dataSource.getConnection();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
   
    
    public static ResultSet getAllInventory() throws SQLException{
       
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = \"UNDELIVERED\";",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        return statement.executeQuery();
       
    }
    public static int createNewInventoryItem(String sku,String name,String move_in_date,String move_out_date,boolean perishable,String expiry_date,boolean damaged,String delivery_address,String deliveryTo) throws SQLException{
        PreparedStatement statement = connection.prepareStatement("INSERT INTO inventory_table(sku,name,move_in_date,move_out_date,perishable,expiry,damaged,delivery_address,delivery_to_name) VALUES (?,?,?,?,?,?,?,?,?)",PreparedStatement.RETURN_GENERATED_KEYS);
        statement.setString(1,sku);
        statement.setString(2,name);
        statement.setDate(3, Date.valueOf(move_in_date));
        statement.setDate(4,Date.valueOf(move_out_date));
        statement.setBoolean(5, perishable);
        
        
        if(expiry_date == null || expiry_date.isEmpty()){
            statement.setNull(6, 0);
        }else{
        statement.setDate(6,Date.valueOf(expiry_date));
        }
        
        statement.setBoolean(7,damaged);
        statement.setString(8, delivery_address);
        statement.setString(9,deliveryTo);
        statement.execute();
        
        ResultSet generatedKeys = statement.getGeneratedKeys();
        int resultId = 0;
        while(generatedKeys.next()) resultId = generatedKeys.getInt(1);
        return resultId;
    }
    public static void deleteInventoryItem(String id) throws SQLException{
        PreparedStatement statement = connection.prepareStatement("DELETE FROM inventory_table WHERE inventory_id = ?");
        statement.setString(1,id);
        statement.execute();
    }
    
    public static ResultSet getUndeliveredInventoryAccToPriority()throws SQLException{
           PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = false ORDER BY ABS(DATEDIFF(move_out_date, NOW())), perishable DESC;",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        return statement.executeQuery();
    }
    public static ResultSet getDeliveredInventory() throws SQLException{
           PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = true",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        return statement.executeQuery();
    }
    public static ResultSet getDeliveryDetails() throws SQLException{
           PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table inv INNER JOIN delivery_table dlt ON inv.inventory_id = dlt.inventory_id",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        return statement.executeQuery();
    }
    
    public static void setDeliveredInventory(String id) throws SQLException{
           PreparedStatement statement = connection.prepareStatement("UPDATE inventory_table set delivery_status = true WHERE inventory_id = ?");
           statement.setInt(1,Integer.parseInt(id));
    }
    
    //Gets the status of the assigned inventory status 
    public static ResultSet getAssignedInventoryStatus() throws SQLException{
        PreparedStatement  statement = connection.prepareStatement("SELECT * FROM delivery_table dt INNER JOIN agent_details ad ON dt.agent_id = ad.agent_id INNER JOIN inventory_table as it  ON it.inventory_id = dt.inventory_id WHERE dt.status <> \"DELIVERED\";");
        return statement.executeQuery();
    }
}
