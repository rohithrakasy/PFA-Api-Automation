function fn(){

    function randomValueGenerator(){
        let randomVal = Math.floor( 100 + Math.random() * 900);

        return randomVal;
    }

    return {

        randomValueGenerator: randomValueGenerator

    };

}