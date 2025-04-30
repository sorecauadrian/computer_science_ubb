package org.example.features.search;

import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Issue;
import net.thucydides.core.annotations.Managed;
import net.thucydides.core.annotations.Pending;
import net.thucydides.core.annotations.Steps;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;

import org.example.steps.serenity.EndUserSteps;

@RunWith(SerenityRunner.class)
public class SearchByKeywordStory {

    @Managed(uniqueSession = true)
    public WebDriver webdriver;

    @Steps
    public EndUserSteps anna;

    @Issue("#WIKI-1")
    @Test
    public void searching_by_keyword_apple_should_display_the_corresponding_article() {
        anna.is_the_home_page();
        anna.looks_for("apple");
        //anna.should_see_definition("A common, round fruit produced by the tree Malus domestica");
        //anna.should_see_definition("Rezultatele cautarii dupa: apple");
        anna.should_see_definition("Rachel Appleby: Observations & Reflections: Learning from each other, learning from yourself");

    }


    @Test
    public void searching_by_keyword_banana_should_display_the_corresponding_article() {
        anna.is_the_home_page();
        anna.looks_for("pear");
        anna.should_see_definition("The First Balkan Workshop on Fixed Point Theory and Applications Babeș-Bolyai University Cluj-Napoca");
    }

    @Test
    public void searching_by_ambiguous_keyword_should_display_the_disambiguation_page() {
        anna.is_the_home_page();
        anna.looks_for("cox");
        anna.should_see_definition("Dr. Alessandro Paolini, TU Kaiserslautern, Germania: Distinguished Subexpressions in Coxeter Groups and Endomorphism Algebras");
    }

} 