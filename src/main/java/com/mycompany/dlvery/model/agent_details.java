/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.model;

import java.io.Serializable;

/**
 *
 * @author atulv
 */
public class agent_details implements Serializable{
    int agent_id;
    String agent_name,agent_email,agent_auth_id,auth_status;

    public int getAgent_id() {
        return agent_id;
    }

    public void setAgent_id(int agent_id) {
        this.agent_id = agent_id;
    }

    public String getAgent_name() {
        return agent_name;
    }

    public void setAgent_name(String agent_name) {
        this.agent_name = agent_name;
    }

    public String getAgent_email() {
        return agent_email;
    }

    public void setAgent_email(String agent_email) {
        this.agent_email = agent_email;
    }

    public String getAgent_auth_id() {
        return agent_auth_id;
    }

    public void setAgent_auth_id(String agent_auth_id) {
        this.agent_auth_id = agent_auth_id;
    }

    public String getAuth_status() {
        return auth_status;
    }

    public void setAuth_status(String auth_status) {
        this.auth_status = auth_status;
    }
    public agent_details(){
        
    }
}
