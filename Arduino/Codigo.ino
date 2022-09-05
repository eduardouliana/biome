#include <ESP8266WiFi.h>

#include <Firebase_ESP_Client.h>

#include <addons/TokenHelper.h>

/* WiFi credentials */
#define WIFI_SSID "Nome_rede"
#define WIFI_PASSWORD "xxx"

/* API Key */
#define API_KEY "a6s4d6as4das6d4as654dfasdladlskad912"

/* Project ID */
#define FIREBASE_PROJECT_ID "project_id"

/* Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "xxx@gmail.com"
#define USER_PASSWORD "xxx"

FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

bool taskCompleted = false;

unsigned long dataMillis = 0;

int count = 0;
int count02 = 0;

String ID_FIXO = "43803050-223c-11ed-8a48-e1d138bf087e";

void setup()
{

    Serial.begin(115200);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print(".");
        delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    /* Assign the api key (required) */
    config.api_key = API_KEY;

    /* Assign the user sign in credentials */
    auth.user.email = USER_EMAIL;
    auth.user.password = USER_PASSWORD;

    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

#if defined(ESP8266)
    // In ESP8266 required for BearSSL rx/tx buffer for large data handle, increase Rx size as needed.
    fbdo.setBSSLBufferSize(2048 /* Rx buffer size in bytes from 512 - 16384 */, 2048 /* Tx buffer size in bytes from 512 - 16384 */);
#endif

    // Limit the size of response payload to be collected in FirebaseData
    fbdo.setResponseSize(2048);

    Firebase.begin(&config, &auth);

    Firebase.reconnectWiFi(true);
}

void loop(){
    if (Firebase.ready()){
        //digitalWrite(led1, HIGH);
        //bool sensor = digitalRead(pinSensor);
        //bool sensor02 = digitalRead(pinSensor02); 
        
        delay(5000);
        
        if(true){
            //digitalWrite(led2, HIGH);
            IncrementarGarrafasFirebase("itens_2l"); 
            IncrementarPontosFirebase("itens_2l"); 
        }
        
        delay(5000);

        if(true){
            //digitalWrite(led2, HIGH);
            IncrementarGarrafasFirebase("itens_500ml");
            IncrementarPontosFirebase("itens_500ml");
        }
    }
}

void IncrementarGarrafasFirebase(String sensor) {
    std::vector<struct fb_esp_firestore_document_write_t> writes;
  
    struct fb_esp_firestore_document_write_t transform_write;
    transform_write.type = fb_esp_firestore_document_write_type_transform;
    
    transform_write.document_transform.transform_document_path = "usuarios/" + ID_FIXO;
    
    struct fb_esp_firestore_document_write_field_transforms_t field_transforms;
    
    field_transforms.fieldPath = sensor;
    
    field_transforms.transform_type = fb_esp_firestore_transform_type_increment;
    
    FirebaseJson values;
    
    values.set("integerValue", "1"); // incrementa 1 no valor que estiver no Firebase
    
    field_transforms.transform_content = values.raw();
    
    transform_write.document_transform.field_transforms.push_back(field_transforms);
    
    writes.push_back(transform_write);
    
    if (Firebase.Firestore.commitDocumentAsync(&fbdo, FIREBASE_PROJECT_ID, "", writes , ""))
        Serial.println("ok");
    else
        Serial.println(fbdo.errorReason());
}

void IncrementarPontosFirebase(String sensor) {
    std::vector<struct fb_esp_firestore_document_write_t> writes;
  
    struct fb_esp_firestore_document_write_t transform_write;
    transform_write.type = fb_esp_firestore_document_write_type_transform;
    
    transform_write.document_transform.transform_document_path = "usuarios/" + ID_FIXO;
    
    struct fb_esp_firestore_document_write_field_transforms_t field_transforms;
    
    field_transforms.fieldPath = "pontos";
    
    field_transforms.transform_type = fb_esp_firestore_transform_type_increment;
    
    FirebaseJson values;

    if (sensor == "itens_500ml") {    
      values.set("integerValue", "5");
    } else {
      values.set("integerValue", "20");
    }
    
    field_transforms.transform_content = values.raw();
    
    transform_write.document_transform.field_transforms.push_back(field_transforms);
    
    writes.push_back(transform_write);
    
    if (Firebase.Firestore.commitDocumentAsync(&fbdo, FIREBASE_PROJECT_ID, "", writes , ""))
        Serial.println("ok");
    else
        Serial.println(fbdo.errorReason());
}