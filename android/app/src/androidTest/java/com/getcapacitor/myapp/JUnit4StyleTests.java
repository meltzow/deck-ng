package com.getcapacitor.myapp;

import androidx.test.ext.junit.rules.ActivityScenarioRule;

import net.meltzow.deckng.MainActivity;

import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.locale.LocaleTestRule;

@RunWith(JUnit4.class)
public class JUnit4StyleTests {
    @ClassRule
    public static final LocaleTestRule localeTestRule = new LocaleTestRule();

    @Rule
    public ActivityScenarioRule<MainActivity> activityRule = new ActivityScenarioRule<>(MainActivity.class);

    @Test
    public void testTakeScreenshot() {
        Screengrab.screenshot("before_button_click");

//        onView(withId(R.id.fab)).perform(click());

        Screengrab.screenshot("after_button_click");
    }
}
