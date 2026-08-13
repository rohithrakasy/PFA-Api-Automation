import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate runtests(){
        return Karate.run("classpath:features/Campaign/GetCampaign.feature");
    }
}
