/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;

/**
 *
 * @author atulv
 */
public class agentAuthenticationQueries {
    
    DataSource dataSource;
    static Connection connection;
    public agentAuthenticationQueries(){
        try{
            dataSource = connectionPool.getDataSource();
        connection = dataSource.getConnection();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    //Returns false if the agent doesnt exist and true if the agent exists
    public static boolean doesAgentExist(String auth_id) throws SQLException{
        PreparedStatement statement =  connection.prepareStatement("SELECT * FROM agent_details where agent_auth_id = ?");
        statement.setString(1, auth_id);
        
        return statement.executeQuery().next();
    }
    
    //returns true if the agent is authorized
    public static boolean isAgentAuthorized(String auth_id) throws SQLException{
         PreparedStatement statement =  connection.prepareStatement("SELECT auth_status FROM agent_details where agent_auth_id = ?");
        statement.setString(1, auth_id);
        return statement.executeQuery().getInt(1) == 1;
    }
    
    
    //creates the agent
    public static void createAgent(String name, String email,String auth_id) throws SQLException{
        PreparedStatement statement = connection.prepareStatement("INSERT INTO agent_details(agent_name,agent_email,agent_auth_id) VALUES (?,?,?)");
        statement.setString(1,name);
        statement.setString(2,email);
        statement.setString(3,auth_id);
        statement.execute();
        
    }
    
    public static void updateAgentAuth(String auth_id) throws SQLException{
        PreparedStatement statement = connection.prepareStatement("UPDATE agent_details SET agent_auth_status = true WHERE agent_auth_id = ?");
        statement.setString(1, auth_id);
        statement.execute();
    }
    
    public static ResultSet getPendingAgentAuths() throws SQLException{
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM agent_table WHERE agent_auth_status = false");
        return statement.executeQuery();
    }
    
    public void closeConnection() throws SQLException{
        connection.close();
    }
    
}
