/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import com.mycompany.dlvery.model.assigned_delivery;
import com.mycompany.dlvery.model.delivery_details;
import com.mycompany.dlvery.model.inventory_table;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import javax.sql.DataSource;

/**
 *
 * @author atulv
 */
public class inventoryQueries implements Serializable {

    static DataSource dataSource;

    public inventoryQueries() {
        try {
            dataSource = connectionPool.getDataSource();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<inventory_table> getAllInventory() {
        List<inventory_table> inventory = new LinkedList<inventory_table>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = \"UNASSIGNED\";", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                inventory_table item = new inventory_table();
                item.setInventory_id(x.getInt("inventory_id"));
                item.setSku(x.getString("sku"));
                item.setName(x.getString("name"));
                item.setMove_in_date(x.getString("move_in_date"));
                item.setMove_out_date(x.getString("move_out_date"));
                item.setPerishable(x.getString("perishable"));
                item.setExpiry(x.getString("expiry"));
                item.setDamaged(x.getString("damaged"));
                item.setDelivery_address(x.getString("delivery_address"));
                item.setDelivery_status(x.getString("delivery_status"));
                item.setDelivery_to_name(x.getString("delivery_to_name"));
                inventory.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            return inventory;
        }

    }

    public static int createNewInventoryItem(String sku, String name, String move_in_date, String move_out_date, boolean perishable, String expiry_date, boolean damaged, String delivery_address, String deliveryTo) throws SQLException {
        int resultId = 0;
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("INSERT INTO inventory_table(sku,name,move_in_date,move_out_date,perishable,expiry,damaged,delivery_address,delivery_to_name) VALUES (?,?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setString(1, sku);
            statement.setString(2, name);
            statement.setDate(3, Date.valueOf(move_in_date));
            statement.setDate(4, Date.valueOf(move_out_date));
            statement.setBoolean(5, perishable);

            if (expiry_date == null || expiry_date.isEmpty()) {
                statement.setNull(6, 0);
            } else {
                statement.setDate(6, Date.valueOf(expiry_date));
            }

            statement.setBoolean(7, damaged);
            statement.setString(8, delivery_address);
            statement.setString(9, deliveryTo);
            statement.execute();

            ResultSet generatedKeys = statement.getGeneratedKeys();

            while (generatedKeys.next()) {
                resultId = generatedKeys.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return resultId;
        }
    }

    public static void deleteInventoryItem(String id) {
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("DELETE FROM inventory_table WHERE inventory_id = ?");
            statement.setString(1, id);
            statement.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<inventory_table> getUndeliveredInventoryAccToPriority() {
        List<inventory_table> inventory = new LinkedList<inventory_table>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = \"UNDELIVERED\" ORDER BY ABS(DATEDIFF(move_out_date, NOW())), perishable DESC;", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                inventory_table item = new inventory_table();
                item.setInventory_id(x.getInt("inventory_id"));
                item.setSku(x.getString("sku"));
                item.setName(x.getString("name"));
                item.setMove_in_date(x.getString("move_in_date"));
                item.setMove_out_date(x.getString("move_out_date"));
                item.setPerishable(x.getString("perishable"));
                item.setExpiry(x.getString("expiry"));
                item.setDamaged(x.getString("damaged"));
                item.setDelivery_address(x.getString("delivery_address"));
                item.setDelivery_status(x.getString("delivery_status"));
                item.setDelivery_to_name(x.getString("delivery_to_name"));
                inventory.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            return inventory;
        }
    }

    public static List<inventory_table> getDeliveredInventory() {
        List<inventory_table> inventory = new LinkedList<inventory_table>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = \"DELIVERED\"", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                inventory_table item = new inventory_table();
                item.setInventory_id(x.getInt("inventory_id"));
                item.setSku(x.getString("sku"));
                item.setName(x.getString("name"));
                item.setMove_in_date(x.getString("move_in_date"));
                item.setMove_out_date(x.getString("move_out_date"));
                item.setPerishable(x.getString("perishable"));
                item.setExpiry(x.getString("expiry"));
                item.setDamaged(x.getString("damaged"));
                item.setDelivery_address(x.getString("delivery_address"));
                item.setDelivery_status(x.getString("delivery_status"));
                item.setDelivery_to_name(x.getString("delivery_to_name"));
                inventory.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            return inventory;
        }
    }

    // delivery table innner joined with inventory table
    public static List<delivery_details> getDeliveryDetails() {
        List<delivery_details> inventory = new LinkedList<delivery_details>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT inv.inventory_id,sku,name,move_in_date,move_out_date,perishable,expiry,damaged,delivery_address,delivery_status,delivery_to_name,delivery_id,agent_id,status,reciever_name,reciever_signature,delivery_date FROM inventory_table inv INNER JOIN delivery_table dlt ON inv.inventory_id = dlt.inventory_id", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                delivery_details item = new delivery_details();
                item.setInventory_id(x.getInt("inventory_id"));
                item.setSku(x.getString("sku"));
                item.setName(x.getString("name"));
                item.setMove_in_date(x.getString("move_in_date"));
                item.setMove_out_date(x.getString("move_out_date"));
                item.setPersiable(x.getString("perishable"));
                item.setExpiry(x.getString("expiry"));
                item.setDamaged(x.getString("damaged"));
                item.setDelivery_address(x.getString("delivery_address"));
                item.setDelivery_status(x.getString("delivery_status"));
                item.setDelivery_to_name(x.getString("delivery_to_name"));

                item.setDelivery_id(x.getInt("delivery_id"));
                item.setAgent_id(x.getInt("agent_id"));
                item.setStatus(x.getString("status"));
                item.setReciever_name(x.getString("reciever_name"));

                //reciever signature is a blob
                item.setDelivery_date(x.getString("delivery_date"));
                inventory.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            return inventory;
        }
    }

    public static void setDeliveredInventory(String id) {

        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("UPDATE inventory_table set delivery_status = \"DELIVERED\" WHERE inventory_id = ?");
            statement.setInt(1, Integer.parseInt(id));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Gets the status of the assigned inventory status 

    public static List<assigned_delivery> getAssignedInventoryStatus() {
        List<assigned_delivery> list= new LinkedList<>();
        try(Connection connection = dataSource.getConnection()){
           PreparedStatement statement = connection.prepareStatement("SELECT dt.delivery_id,it.inventory_id,ad.agent_id,status,reciever_name,reciever_signature,delivery_date,agent_name,agent_email,agent_auth_id,auth_status,sku,name,move_in_date,move_out_date,perishable,expiry,damaged,delivery_address,delivery_to_name FROM delivery_table dt INNER JOIN agent_details ad ON dt.agent_id = ad.agent_id INNER JOIN inventory_table as it  ON it.inventory_id = dt.inventory_id WHERE dt.status <> \"DELIVERED\";", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
           ResultSet res = statement.executeQuery();
           while(res.next()){
               assigned_delivery del = new assigned_delivery();
               del.setDelivery_id(res.getInt("delivery_id"));
               del.setInventory_id(res.getInt("inventory_id"));
               del.setAgent_id(res.getInt("agent_id"));
               del.setStatus(res.getString("status"));
               del.setReciever_name(res.getString("reciever_name"));
               del.setAgent_name(res.getString("agent_name"));
               del.setAgent_auth_id(res.getString("agent_auth_id"));
               del.setAuth_status(res.getString("auth_status"));
               del.setSku(res.getString("sku"));
               del.setName(res.getString("name"));
               del.setMove_in_date(res.getString("move_in_date"));
               del.setMove_out_date(res.getString("move_out_date"));
               del.setPerishable(res.getString("perishable"));
               del.setExpiry(res.getString("expiry"));
               del.setDelivery_address(res.getString("delivery_address"));
               del.setDelivery_to_name(res.getString("delivery_to_name"));
               list.add(del);
           }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            return list;
        }
       
    }

    public static List<inventory_table> getUnAssigned() {
        List<inventory_table> inventory = new LinkedList<inventory_table>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM inventory_table WHERE delivery_status = \"UNASSIGNED\" ORDER BY ABS(DATEDIFF(move_out_date, NOW())), perishable DESC;", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                inventory_table item = new inventory_table();
                item.setInventory_id(x.getInt("inventory_id"));
                item.setSku(x.getString("sku"));
                item.setName(x.getString("name"));
                item.setMove_in_date(x.getString("move_in_date"));
                item.setMove_out_date(x.getString("move_out_date"));
                item.setPerishable(x.getString("perishable"));
                item.setExpiry(x.getString("expiry"));
                item.setDamaged(x.getString("damaged"));
                item.setDelivery_address(x.getString("delivery_address"));
                item.setDelivery_status(x.getString("delivery_status"));
                item.setDelivery_to_name(x.getString("delivery_to_name"));
                inventory.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            return inventory;
        }
    }
}
