function fn(){

    var env = karate.env;

    if(!env){
        env = 'dev';
    }

    karate.log("Running tests in environment: ", env)


    var config = {
        env:env
    };

    if(env === 'dev'){
        config.baseUrl = 'https://devapi.suretyforce.com/apim'
    }

    else if(env === 'qa'){
        config.baseUrl = 'https://stagingapi.suretyforce.com/apim'
    }

    config.email = karate.properties['email'];
    config.password = karate.properties['password']
    config.deviceId = karate.properties['deviceId'];

    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 10000);


    return config;
}