package com.getcapacitor.myapp;

import static androidx.test.espresso.action.ViewActions.clearText;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.web.sugar.Web.onWebView;
import static androidx.test.espresso.web.webdriver.DriverAtoms.clearElement;
import static androidx.test.espresso.web.webdriver.DriverAtoms.findElement;
import static androidx.test.espresso.web.webdriver.DriverAtoms.webClick;
import static androidx.test.espresso.web.webdriver.DriverAtoms.webKeys;

import androidx.test.espresso.web.model.Atom;
import androidx.test.espresso.web.model.ElementReference;
import androidx.test.espresso.web.webdriver.Locator;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.rule.ActivityTestRule;

import net.meltzow.deckng.MainActivity;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import tools.fastlane.screengrab.FalconScreenshotStrategy;
import tools.fastlane.screengrab.Screengrab;
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

//    @BeforeClass
//    public static void beforeAll() {
//      CleanStatusBar.enableWithDefaults();
//    }

//    @AfterClass
//    public static void afterAll() {
//      CleanStatusBar.disable();
//    }

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

    Atom<ElementReference> elementMenu = findElement(Locator.ID, "menu-button");
    onWebView().withElement(elementMenu).perform(webClick());

    Screengrab.screenshot("MenuScreen");


    // find main menu button and click it
    String urlInputXPath = "//input[@name='url']";
    String loginBtn= "//ion-button[@type='submit']";

    Atom<ElementReference> elementURL = findElement(Locator.XPATH, urlInputXPath);
    onWebView().withContextualElement(elementURL).perform(webKeys("https://my.nextcloud.org"));

    Screengrab.screenshot("LoginScreen");

    onWebView().withElement(elementURL).perform(clearElement()).perform(webKeys("http://192.168.178.25:8080"));
    Atom<ElementReference> element3 = findElement(Locator.XPATH, loginBtn);
    onWebView().withElement(element3).perform(webClick());

    Thread.sleep(10000);

    Screengrab.screenshot("BoardsOverviewsScreen");

    String scrumBoardCard = "//ion-item[@id='board-1']";
    Atom<ElementReference> elementScrumBoardCard = findElement(Locator.XPATH, scrumBoardCard);
    onWebView().withElement(elementScrumBoardCard).perform(webClick());

    Thread.sleep(1000);
    Screengrab.screenshot("BoardsDetailsScreen");

  }


}
