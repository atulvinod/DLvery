package com.mycompany.dlvery.datalayer;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import javax.sql.DataSource;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author atulv
 */
public class connectionPool {

    private static DataSource dataSource;

    public static DataSource getDataSource() {
        if (dataSource == null) {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:mysql://us-cdbr-iron-east-05.cleardb.net/heroku_11c9248fe100c56");
           config.setUsername("bd23c203bf2c25");
            //config.setUsername("bd23c203bf2c26");
            config.setPassword("a85a1c3c");
            config.setDriverClassName("com.mysql.jdbc.Driver");
            config.setMaximumPoolSize(10);
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

            dataSource = new HikariDataSource(config);
        }
        return dataSource;
    }

}
