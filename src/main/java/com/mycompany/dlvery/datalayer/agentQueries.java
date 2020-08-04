/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import com.mycompany.dlvery.model.agent_details;
import com.mycompany.dlvery.model.delivery_table;
import com.mycompany.dlvery.model.pending_for_agent;
import java.io.Serializable;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;
import javax.sql.DataSource;
import javax.sql.rowset.serial.SerialBlob;

/**
 *
 * @author atulv
 */
public class agentQueries implements Serializable {

    static DataSource dataSource;

    public agentQueries() {
        try {
            dataSource = connectionPool.getDataSource();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<agent_details> getAllAgentDetails() {

        List<agent_details> list = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE auth_status = true");
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                agent_details d = new agent_details();
                d.setAgent_id(x.getInt("agent_id"));
                d.setAgent_name(x.getString("agent_name"));
                d.setAgent_email(x.getString("agent_email"));
                d.setAgent_auth_id(x.getString("agent_auth_id"));
                d.setAuth_status(x.getString("auth_status"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<agent_details> getAgentDetail(String id) {
        List<agent_details> list = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE agent_id = ?");
            statement.setInt(1, Integer.parseInt(id));
            ResultSet x = statement.executeQuery();
            while (x.next()) {
                agent_details d = new agent_details();
                d.setAgent_id(x.getInt("agent_id"));
                d.setAgent_name(x.getString("agent_name"));
                d.setAgent_email(x.getString("agent_email"));
                d.setAgent_auth_id(x.getString("agent_auth_id"));
                d.setAuth_status(x.getString("auth_status"));
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void assignDeliveryToAgent(String agent_id, String inventory_id) {
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("INSERT INTO delivery_table(inventory_id,agent_id) VALUES(?,?)");
            statement.setInt(1, Integer.parseInt(inventory_id));
            statement.setInt(2, Integer.parseInt(agent_id));
            statement.execute();
            PreparedStatement statement2 = connection.prepareStatement("UPDATE inventory_table SET delivery_status = \"UNDELIVERED\" WHERE inventory_id = ?");
            statement2.setInt(1, Integer.parseInt(inventory_id));
            statement2.execute();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static List<pending_for_agent> getPendingDeliveriesForAgent(String agent_id) {
         List<pending_for_agent> list = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT dt.inventory_id, dt.delivery_id, agent_id,status,reciever_name,delivery_date,sku,name,move_in_date,move_out_date,perishable,expiry,damaged,delivery_address,delivery_status,delivery_to_name FROM delivery_table dt INNER JOIN inventory_table it ON dt.inventory_id = it.inventory_id WHERE dt.agent_id = ? AND dt.status = \"PENDING\"", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            statement.setString(1, agent_id);
            ResultSet x = statement.executeQuery();
            while(x.next()){
                pending_for_agent item = new pending_for_agent();
                item.setInventory_id(x.getInt("inventory_id"));
                item.setAgent_id(x.getInt("agent_id"));
                item.setStatus(x.getString("status"));
                item.setReciever_name(x.getString("reciever_name"));
                item.setDelivery_name(x.getString("name"));
                item.setMove_in_date(x.getString("move_in_date"));
                item.setMove_out_date(x.getString("move_out_date"));
                item.setPerishable(x.getString("perishable"));
                item.setExpiry(x.getString("expiry"));
                item.setDamaged(x.getString("damaged"));
                item.setDelivery_address(x.getString("delivery_address"));
                item.setDelivery_status(x.getString("delivery_status"));
                item.setDelivery_to_name(x.getString("delivery_to_name"));
                item.setDelivery_id(x.getInt("delivery_id"));
                item.setSku(x.getString("sku"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void updateDeliveryStatus(int delivery_id, String recipient_name, String status, byte[] image) {
        try (Connection connection = dataSource.getConnection()) {

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            System.out.println(dtf.format(now));

            PreparedStatement statement = connection.prepareStatement("UPDATE delivery_table SET reciever_name = ?, status = ?, delivery_date = ?  WHERE delivery_id = ?");
            statement.setInt(4, delivery_id);
            statement.setDate(3, Date.valueOf(dtf.format(now)));
            statement.setString(2, status);
            statement.setString(1, recipient_name);
            statement.execute();

            if (image != null) {
                PreparedStatement insertImage = connection.prepareStatement("UPDATE delivery_table SET reciever_signature = ? WHERE delivery_id = ?");
                insertImage.setBlob(1, new SerialBlob(image));
                insertImage.setInt(2, delivery_id);
                insertImage.execute();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static List<delivery_table> getDeliveredForAgent(String agent_id) {
        List<delivery_table> list = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement p = connection.prepareStatement("SELECT dt.delivery_id,dt.inventory_id,agent_id,status,reciever_name,delivery_date,sku FROM delivery_table dt INNER JOIN inventory_table it ON dt.inventory_id = it.inventory_id WHERE dt.status = \"DELIVERED\" AND dt.agent_id = ?");;
            p.setInt(1, Integer.parseInt(agent_id));
            ResultSet x = p.executeQuery();
            while (x.next()) {
                delivery_table item = new delivery_table();
                item.setDelivery_id(x.getInt("delivery_id"));
                item.setInventory_id(x.getInt("inventory_id"));
                item.setAgent_id(x.getInt("agent_id"));
                item.setStatus(x.getString("status"));
                item.setReciever_name(x.getString("reciever_name"));
                item.setDelivery_date(x.getString("delivery_date"));
                item.setSku(x.getString("sku"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
