package org.example.steps.serenity;

import net.thucydides.core.annotations.Step;
import org.example.pages.EmagPage;

import java.util.List;
import java.util.stream.Collectors;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class EmagEndUserSteps {

    EmagPage emagPage;

    @Step
    public void enters(String keyword) {
        emagPage.enter_keywords(keyword);
    }

    @Step
    public void starts_search() {
        emagPage.lookup_terms();
    }

    @Step
    public void filter() {
        emagPage.filter();
    }

    @Step
    public void should_see_item(String item) {
        assertThat(emagPage.getItems(), hasItem(containsString(item)));
    }
    @Step
    public void should_respect_filter() {
        List<Double> tmp = emagPage.getItemsPrices().stream()
                .filter(x -> x > 50)
                .collect(Collectors.toList());

        assertThat("prices not in valid range", tmp.isEmpty());
    }

    @Step
    public void is_the_home_page() {
        emagPage.open();
    }

    @Step
    public void looks_for(String term, Boolean filter) {
        enters(term);
        starts_search();
        if(filter){
            this.filter();
        }
    }
}