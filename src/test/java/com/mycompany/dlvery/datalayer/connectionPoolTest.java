/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.datalayer;

import java.sql.Connection;
import javax.sql.DataSource;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author atulv
 */
public class connectionPoolTest {

    DataSource result = null;
    Connection connection = null;

    public connectionPoolTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
        boolean expected = true;
        boolean testResult = true;

        try {
            result = connectionPool.getDataSource();
            connection = result.getConnection();
            
        } catch (Exception e) {
            e.printStackTrace();
            testResult = false;
        }
        assertEquals(expected, testResult);
    }

    @After
    public void tearDown() {
        try {
            connection.close();
        } catch (Exception e) {

        }
    }

    /**
     * Test of getDataSource method, of class connectionPool.
     */
    @Test
    public void testGetDataSource() {
        System.out.println("getDataSource");

        assertNotNull(connection);
        // TODO review the generated test code and remove the default call to fail.

    }

}
