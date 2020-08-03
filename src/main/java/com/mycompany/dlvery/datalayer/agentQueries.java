/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    public static ResultSet getAllAgentDetails() {
        ResultSet x = null;
        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE auth_status = true");
            x = statement.executeQuery();
       
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }

    public static ResultSet getAgentDetail(String id) {
        ResultSet x = null;
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE agent_id = ?");
            statement.setInt(1, Integer.parseInt(id));
            x = statement.executeQuery();
           
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
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

    public static ResultSet getPendingDeliveriesForAgent(String agent_id) {
        ResultSet x = null;
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM delivery_table dt INNER JOIN inventory_table it ON dt.inventory_id = it.inventory_id WHERE dt.agent_id = ? AND dt.status = \"PENDING\"", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            statement.setString(1, agent_id);
            x = statement.executeQuery();
          
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
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

    public static ResultSet getDeliveredForAgent(String agent_id) {
        ResultSet x = null;
        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement p = connection.prepareStatement("SELECT * FROM delivery_table WHERE status = \"DELIVERED\" AND agent_id = ?");;
            p.setInt(1, Integer.parseInt(agent_id));
            x = p.executeQuery();
       
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }
}
