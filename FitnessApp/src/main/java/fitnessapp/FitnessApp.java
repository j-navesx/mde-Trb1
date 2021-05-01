/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fitnessapp;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;
/**
 *
 * @author João Naves & Guilherme Pombo
 */
public class FitnessApp {
    private String appid;
    private JSONObject parseResponse(HttpResponse<String> response){
        return new JSONObject(response.body());
    }
    public JSONObject create_user(String username, String password, String email, 
            String name, float weight, int height, String bday, char gender){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"create_user\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"username\": \"%s\","
                            + "\n\t\t\"password\": \"%s\","
                            + "\n\t\t\"email\": \"%s\","
                            + "\n\t\t\"name\": \"%s\","
                            + "\n\t\t\"weight\": %s,"
                            + "\n\t\t\"height\": %s,"
                            + "\n\t\t\"bday\": \"%s\","
                            + "\n\t\t\"gender\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, username, password, email, name, weight, height, bday, gender);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return parseResponse(response);
    }
    public static void main(String[] args){
        FitnessApp fit = new FitnessApp();
        JSONObject create_user = fit.create_user("j.naves2", "mde", "j.naves@email", "Naves", 74, 171, "2000-08-12", 'M');
    }
}

