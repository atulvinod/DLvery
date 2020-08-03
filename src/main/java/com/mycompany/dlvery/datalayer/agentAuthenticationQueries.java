/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;

/**
 *
 * @author atulv
 */
public class agentAuthenticationQueries implements Serializable {

    static DataSource dataSource;

    public agentAuthenticationQueries() {
        try {
            dataSource = connectionPool.getDataSource();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Returns false if the agent doesnt exist and true if the agent exists
    public static boolean doesAgentExist(String auth_id) {
        boolean x = false;

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details where agent_auth_id = ?");
            statement.setString(1, auth_id);

            x = statement.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return x;
        }
    }

    //returns true if the agent is authorized
    public static boolean isAgentAuthorized(String auth_id) {
        int result = 0;

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement statement = connection.prepareStatement("SELECT auth_status FROM agent_details where agent_auth_id = ?");
            statement.setString(1, auth_id);
            ResultSet s = statement.executeQuery();

            connection.close();
            while (s.next()) {
                result = s.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return result != 0;
        }
    }

    //creates the agent
    public static void createAgent(String name, String email, String auth_id) {
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("INSERT INTO agent_details(agent_name,agent_email,agent_auth_id) VALUES (?,?,?)");
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, auth_id);

            statement.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void updateAgentAuth(String auth_id) {
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("UPDATE agent_details SET auth_status = true WHERE agent_auth_id = ?");
            statement.setString(1, auth_id);
            statement.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static ResultSet getPendingAgentAuths() {
        ResultSet s = null;
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE auth_status = false");
            s = statement.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return s;
        }
    }

    public static int getAgentID(String id) throws SQLException {
        int agent_id = 0;

        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT agent_id FROM agent_details WHERE agent_auth_id = ?");
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                agent_id = rs.getInt("agent_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return agent_id;

        }
    }

}
