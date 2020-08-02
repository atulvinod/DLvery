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

    DataSource dataSource;
    static Connection connection;

    public agentQueries() {
        try {
            dataSource = connectionPool.getDataSource();
            connection = dataSource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static ResultSet getAllAgentDetails() throws SQLException {
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE auth_status = true");
        return statement.executeQuery();
    }

    public static ResultSet getAgentDetail(String id) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE agent_id = ?");
        statement.setInt(1, Integer.parseInt(id));
        return statement.executeQuery();
    }

    public static void assignDeliveryToAgent(String agent_id, String inventory_id) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("INSERT INTO delivery_table(inventory_id,agent_id) VALUES(?,?)");
        statement.setInt(1, Integer.parseInt(inventory_id));
        statement.setInt(2, Integer.parseInt(agent_id));
        statement.execute();
        PreparedStatement statement2 = connection.prepareStatement("UPDATE inventory_table SET delivery_status = \"ASSIGNED\" WHERE inventory_id = ?");
        statement2.setInt(1, Integer.parseInt(inventory_id));
        statement2.execute();
    }

    public static ResultSet getPendingDeliveriesForAgent(String agent_id) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM delivery_table dt INNER JOIN inventory_table it ON dt.inventory_id = it.inventory_id WHERE dt.agent_id = ? AND dt.status = \"PENDING\"", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        statement.setString(1, agent_id);
        return statement.executeQuery();
    }

    public static void updateDeliveryStatus(int delivery_id, String recipient_name, String status, byte[] image) throws SQLException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        System.out.println(dtf.format(now));

        PreparedStatement statement = connection.prepareStatement("UPDATE delivery_table SET reciever_name = ?, status = ?, delivery_date = ?  WHERE delivery_id = ?");
        statement.setInt(4, delivery_id);
        statement.setDate(3,Date.valueOf(dtf.format(now)));
        statement.setString(2, status);
        statement.setString(1, recipient_name);
        statement.execute();

        if (image != null) {
            PreparedStatement insertImage = connection.prepareStatement("UPDATE delivery_table SET reciever_signature = ? WHERE delivery_id = ?");
            insertImage.setBlob(1, new SerialBlob(image));
            insertImage.setInt(2, delivery_id);
            insertImage.execute();
        }

    }
}
