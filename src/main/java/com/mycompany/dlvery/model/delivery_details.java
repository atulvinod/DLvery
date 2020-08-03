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
public class delivery_details  implements Serializable {
    int inventory_id,delivery_id,agent_id;
    String sku,name,move_in_date,move_out_date,persiable,expiry,damaged,delivery_address,delivery_status,delivery_to_name,status,reciever_name,reciever_signature,delivery_date;
    public delivery_details(){
        
    }

    public int getInventory_id() {
        return inventory_id;
    }

    public void setInventory_id(int inventory_id) {
        this.inventory_id = inventory_id;
    }

    public int getDelivery_id() {
        return delivery_id;
    }

    public void setDelivery_id(int delivery_id) {
        this.delivery_id = delivery_id;
    }

    public int getAgent_id() {
        return agent_id;
    }

    public void setAgent_id(int agent_id) {
        this.agent_id = agent_id;
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

    public String getPersiable() {
        return persiable;
    }

    public void setPersiable(String persiable) {
        this.persiable = persiable;
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

    public String getDelivery_status() {
        return delivery_status;
    }

    public void setDelivery_status(String delivery_status) {
        this.delivery_status = delivery_status;
    }

    public String getDelivery_to_name() {
        return delivery_to_name;
    }

    public void setDelivery_to_name(String delivery_to_name) {
        this.delivery_to_name = delivery_to_name;
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

    public String getReciever_signature() {
        return reciever_signature;
    }

    public void setReciever_signature(String reciever_signature) {
        this.reciever_signature = reciever_signature;
    }

    public String getDelivery_date() {
        return delivery_date;
    }

    public void setDelivery_date(String delivery_date) {
        this.delivery_date = delivery_date;
    }
}
