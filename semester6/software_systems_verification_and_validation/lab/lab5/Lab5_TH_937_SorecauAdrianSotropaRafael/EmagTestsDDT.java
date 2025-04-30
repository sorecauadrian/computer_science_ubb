package org.example.features.search;


import net.serenitybdd.junit.runners.SerenityParameterizedRunner;
import net.thucydides.core.annotations.Issue;
import net.thucydides.core.annotations.Managed;
import net.thucydides.core.annotations.Steps;
import net.thucydides.junit.annotations.Qualifier;
import net.thucydides.junit.annotations.UseTestDataFrom;
import org.example.steps.serenity.EmagEndUserSteps;
import org.example.steps.serenity.EndUserSteps;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;

@RunWith(SerenityParameterizedRunner.class)
@UseTestDataFrom("src/test/resources/EmagTestData.csv")
public class EmagTestsDDT {
    @Managed(uniqueSession = true)
    public WebDriver webdriver;


    @Steps
    public EmagEndUserSteps endUser;

    public String name;
    public String item;
    public String filter;

    @Qualifier
    public String getQualifier() {
        return name + item + filter;
    }


    @Issue("#EMAG-1")
    @Test
    public void searchWikiByKeywordTestDDT() {
        endUser.is_the_home_page();
        endUser.looks_for(name, !filter.equals("false"));
        endUser.should_see_item(item);
        if(!filter.equals("false")){
            endUser.should_respect_filter();
        }
    }
}