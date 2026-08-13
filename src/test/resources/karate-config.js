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
        config.baseUrl = 'http://pfa-auth-alb-qa-1606533570.us-east-2.elb.amazonaws.com/apim'
    }

    config.email = karate.properties['email'];
    config.password = karate.properties['password']
    config.deviceId = karate.properties['deviceId'];


    return config;
}