package com.getcapacitor.myapp;

import static org.hamcrest.CoreMatchers.containsString;
import static org.junit.Assert.*;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.matcher.ViewMatchers.*;
import static androidx.test.espresso.Espresso.*;
import static androidx.test.espresso.web.sugar.Web.onWebView;
import static androidx.test.espresso.web.webdriver.DriverAtoms.clearElement;
import static androidx.test.espresso.web.webdriver.DriverAtoms.findElement;
import static androidx.test.espresso.web.webdriver.DriverAtoms.getText;
import static androidx.test.espresso.web.webdriver.DriverAtoms.webClick;
import static androidx.test.espresso.web.webdriver.DriverAtoms.webKeys;

import android.content.Context;

import androidx.test.espresso.web.assertion.WebViewAssertions;
import androidx.test.espresso.web.model.Atom;
import androidx.test.espresso.web.model.ElementReference;
import androidx.test.espresso.web.webdriver.DriverAtoms;
import androidx.test.espresso.web.webdriver.Locator;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.platform.app.InstrumentationRegistry;
import androidx.test.rule.ActivityTestRule;

import net.meltzow.deckng.MainActivity;
import net.meltzow.deckng.R;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import tools.fastlane.screengrab.FalconScreenshotStrategy;
import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy;
import tools.fastlane.screengrab.cleanstatusbar.CleanStatusBar;
import tools.fastlane.screengrab.locale.LocaleTestRule;

/**
 * Instrumented test, which will execute on an Android device.
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
@RunWith(AndroidJUnit4.class)
public class ExampleInstrumentedTest {

    @ClassRule
    public static final LocaleTestRule localeTestRule = new LocaleTestRule();

    @Rule
    public ActivityTestRule<MainActivity> activityRule = new ActivityTestRule<>(MainActivity.class);

    @BeforeClass
    public static void beforeAll() {
      CleanStatusBar.enableWithDefaults();
    }

    @AfterClass
    public static void afterAll() {
      CleanStatusBar.disable();
    }

//    @Test
//    public void useAppContext() throws Exception {
//        // Context of the app under test.
//        Context appContext = InstrumentationRegistry.getInstrumentation().getTargetContext();
//
//        assertEquals("net.meltzow.deckng", appContext.getPackageName());
//    }

  @Test
  public void testTakeScreenshot() throws InterruptedException {
    Screengrab.setDefaultScreenshotStrategy(new FalconScreenshotStrategy(activityRule.getActivity()));

    // find main menu button and click it
    String urlInputXPath = "//input[@name='url']";
    String usernameInput= "//input[@name='username']";
    String passwordInput= "//input[@name='password']";
    String loginBtn= "//ion-button[@type='submit']";

    Atom<ElementReference> element4 = findElement(Locator.XPATH, passwordInput);
    onWebView().withElement(element4).perform(webKeys("admin"));

    Atom<ElementReference> element2 = findElement(Locator.XPATH, usernameInput);
    onWebView().withElement(element2).perform(webKeys("admin"));

    Atom<ElementReference> element1 = findElement(Locator.XPATH, urlInputXPath);
    onWebView().withElement(element1).perform(webKeys("http://192.168.178.25:8080"));

    Screengrab.screenshot("LoginScreen");

    Atom<ElementReference> element3 = findElement(Locator.XPATH, loginBtn);
    onWebView().withElement(element3).perform(webClick());

    Thread.sleep(2000);

    Screengrab.screenshot("BoardsScreen");

  }


}
