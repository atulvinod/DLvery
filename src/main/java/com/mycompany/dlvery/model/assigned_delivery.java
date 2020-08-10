/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.model;

import java.io.Serializable;

/**
 * Defines the assigned delivery details which are relevant when the delivery process takes place
 *
 * @author atulv
 */
public class assigned_delivery implements Serializable{
    int delivery_id,inventory_id,agent_id;
    String status,reciever_name,delivery_date,agent_name,agent_auth_id,auth_status,sku,name,move_in_date,move_out_date,perishable,expiry,damaged,delivery_address,delivery_to_name,delivery_from,delivery_to_contact;

    public String getDelivery_from() {
        return delivery_from;
    }

    public void setDelivery_from(String delivery_from) {
        this.delivery_from = delivery_from;
    }

    public String getDelivery_to_contact() {
        return delivery_to_contact;
    }

    public void setDelivery_to_contact(String delivery_to_contact) {
        this.delivery_to_contact = delivery_to_contact;
    }
    public assigned_delivery(){
        
    }

    public int getDelivery_id() {
        return delivery_id;
    }

    public void setDelivery_id(int delivery_id) {
        this.delivery_id = delivery_id;
    }

    public int getInventory_id() {
        return inventory_id;
    }

    public void setInventory_id(int inventory_id) {
        this.inventory_id = inventory_id;
    }

    public int getAgent_id() {
        return agent_id;
    }

    public void setAgent_id(int agent_id) {
        this.agent_id = agent_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReciever_name() {
        return reciever_name;
    }

    public void setReciever_name(String reciever_name) {
        this.reciever_name = reciever_name;
    }

    public String getDelivery_date() {
        return delivery_date;
    }

    public void setDelivery_date(String delivery_date) {
        this.delivery_date = delivery_date;
    }

    public String getAgent_name() {
        return agent_name;
    }

    public void setAgent_name(String agent_name) {
        this.agent_name = agent_name;
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

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMove_in_date() {
        return move_in_date;
    }

    public void setMove_in_date(String move_in_date) {
        this.move_in_date = move_in_date;
    }

    public String getMove_out_date() {
        return move_out_date;
    }

    public void setMove_out_date(String move_out_date) {
        this.move_out_date = move_out_date;
    }

    public String getPerishable() {
        return perishable;
    }

    public void setPerishable(String perishable) {
        this.perishable = perishable;
    }

    public String getExpiry() {
        return expiry;
    }

    public void setExpiry(String expiry) {
        this.expiry = expiry;
    }

    public String getDamaged() {
        return damaged;
    }

    public void setDamaged(String damaged) {
        this.damaged = damaged;
    }

    public String getDelivery_address() {
        return delivery_address;
    }

    public void setDelivery_address(String delivery_address) {
        this.delivery_address = delivery_address;
    }

    public String getDelivery_to_name() {
        return delivery_to_name;
    }

    public void setDelivery_to_name(String delivery_to_name) {
        this.delivery_to_name = delivery_to_name;
    }
    
}
