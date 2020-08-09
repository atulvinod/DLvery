/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import com.mycompany.dlvery.model.agent_details;
import java.io.Serializable;
import java.sql.Connection;
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
            connection.close();
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
            while (s.next()) {
                result = s.getInt(1);
            }
            connection.close();
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
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void updateAgentAuth(String auth_id) {
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("UPDATE agent_details SET auth_status = true WHERE agent_auth_id = ?");
            statement.setString(1, auth_id);
            statement.execute();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<agent_details> getPendingAgentAuths() {
        List<agent_details> list = new LinkedList<>();
        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_details WHERE auth_status = false");
            ResultSet x = statement.executeQuery();
            while(x.next()){
                agent_details item = new agent_details();
                item.setAgent_id(x.getInt("agent_id"));
                item.setAgent_name(x.getString("agent_name"));
                item.setAgent_email(x.getString("agent_email"));
                item.setAgent_auth_id(x.getString("agent_auth_id"));
                item.setAgent_auth_id(x.getString("auth_status"));
                list.add(item);
            }
            
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return list;
        }
    }

    public static int getAgentID(String id) {
        int agent_id = 0;

        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement statement = connection.prepareStatement("SELECT agent_id FROM agent_details WHERE agent_auth_id = ?");
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                agent_id = rs.getInt("agent_id");
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return agent_id;

        }
    }

}
