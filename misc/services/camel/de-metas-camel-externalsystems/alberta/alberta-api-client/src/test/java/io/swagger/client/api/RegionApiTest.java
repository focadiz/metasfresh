/*
 * Patient - Warenwirtschaft (Basis)
 * Synchronisation der Patienten mit der Warenwirtschaft
 *
 * OpenAPI spec version: 1.0.6
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */

package io.swagger.client.api;

import io.swagger.client.ApiException;
import io.swagger.client.model.Region;
import org.junit.Test;
import org.junit.Ignore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * API tests for RegionApi
 */
@Ignore
public class RegionApiTest {

    private final RegionApi api = new RegionApi();

    /**
     * Daten einer einzelnen Region abrufen
     *
     * Szenario - das WaWi fragt bei Alberta nach, wie die Daten der Region mit der angegebenen Id sind
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    public void getRegionTest() throws ApiException {
        String albertaApiKey = null;
        String tenant = null;
        String _id = null;
        Region response = api.getRegion(albertaApiKey, tenant, _id);

        // TODO: test validations
    }
}
