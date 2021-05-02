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
import java.util.Arrays;
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
    
    public void get_AppId(){
        HttpResponse<String> response = null;
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString("{\n\t\"appid\": \"request\"\n}"))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            JSONObject new_appId = parseResponse(response);
            this.appid = new_appId.getString("appid");
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public JSONObject get_activities_names(Arrays activities){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_activities_available\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"activities\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, activities);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_leaderboard(Arrays data){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_leaderboard\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"data\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, data);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_user_activities(Arrays users){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_user_activities\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"users\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, users);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_users_paid(String begin_date, Arrays users){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_users_paid\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"begin_date\": \"%s\","
                            + "\n\t\t\"users\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, begin_date, users);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_nonactive_users(Arrays users){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_nonactive_users\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"users\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, users);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_exercises(Arrays exercises){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_exercises\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"exercises\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, exercises);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_daily_status(String begin_date, String end_date, Arrays status){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_daily_status\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"begin_date\": \"%s\","
                            + "\n\t\t\"end_date\": \"%s\","
                            + "\n\t\t\"status\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, begin_date, end_date, status);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_transactions(String days, Arrays transactions){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_transactions\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"days\": \"%s\","
                            + "\n\t\t\"transactions\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, days, transactions);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_notifications(String days, Arrays notifications){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_notifications\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"days\": \"%s\","
                            + "\n\t\t\"notifications\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, days, notifications);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_friends_request(Arrays users){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_friends_request\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"users\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, users);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_friends_list(Arrays users){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_friends_list\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"users\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, users);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject get_home(String name, int steps, int daily_steps, 
            float weight, int duration, float distance, float calories, String begin_date){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"get_home\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"name\": \"%s\","
                            + "\n\t\t\"steps\": \"%s\","
                            + "\n\t\t\"daily_steps\": \"%s\","
                            + "\n\t\t\"weight\": \"%s\","
                            + "\n\t\t\"duration\": %s,"
                            + "\n\t\t\"distance\": %s,"
                            + "\n\t\t\"calories\": \"%s\","
                            + "\n\t\t\"begin_date\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, name, steps, daily_steps, weight, duration, distance, calories, begin_date);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("GET", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject create_user(String username, String password, String email, 
            String name, int weight, int height, String bday, String gender){
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
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject login(String username, String password){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"login\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"username\": \"%s\","
                            + "\n\t\t\"password\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, username, password);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject create_transaction(float value){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"create_transaction\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"value\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, value);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject create_friends(String name){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"create_friends\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"name\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, name);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject create_exercises(String act_name){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"create_exercises\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"act_name\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, act_name);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject create_activities(String name, float cal_step_mult, float cal_dist_mult, float cal_time_mult){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"create_activities\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"name\": \"%s\","
                            + "\n\t\t\"cal_step_mult\": \"%s\","
                            + "\n\t\t\"cal_dist_mult\": \"%s\","
                            + "\n\t\t\"cal_time_mult\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, name, cal_step_mult, cal_dist_mult, cal_time_mult);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject update_exercises(float distance, int steps, int bpm){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"update_exercises\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"distance\": \"%s\","
                            + "\n\t\t\"steps\": \"%s\","
                            + "\n\t\t\"bpm\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, distance, steps, bpm);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("PATCH", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject update_friends(String name){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"update_friends\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"name\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, name);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("PATCH", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject update_daily_goals(int daily_steps, float daily_cals){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"update_daily_goals\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"daily_steps\": \"%s\","
                            + "\n\t\t\"daily_cals\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, daily_steps, daily_cals);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("PATCH", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
    
    public JSONObject delete_friend(String user){
        HttpResponse<String> response = null;
        try {
            String str = String.format(""
                            + "{\n\t\"appid\": \"%s\","
                            + "\n\t\"action\": \"delete_friend\","
                            + "\n\t\"args\": "
                            + "{\n\t\t\"user\": \"%s\""
                            + "\n\t}\n}", 
                            this.appid, user);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:9000/"))
                    .header("Content-Type", "application/json")
                    .method("DELETE", HttpRequest.BodyPublishers.ofString(str))
                    .build();
            response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(FitnessApp.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(response.body().length() != 0){
            return parseResponse(response);
        }
        return null;
    }
}

