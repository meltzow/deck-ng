package com.getcapacitor.myapp;

import static org.junit.Assert.*;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.matcher.ViewMatchers.*;
import static androidx.test.espresso.Espresso.*;

import android.content.Context;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.platform.app.InstrumentationRegistry;
import androidx.test.rule.ActivityTestRule;

import net.meltzow.deckng.MainActivity;
import net.meltzow.deckng.R;

import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy;
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

//    @Test
//    public void useAppContext() throws Exception {
////      Screengrab.setDefaultScreenshotStrategy(new UiAutomatorScreenshotStrategy());
//        // Context of the app under test.
//        Context appContext = InstrumentationRegistry.getInstrumentation().getTargetContext();
//
//        assertEquals("com.getcapacitor.app", appContext.getPackageName());
//    }

  @Test
  public void testTakeScreenshot() {
    Screengrab.setDefaultScreenshotStrategy(new UiAutomatorScreenshotStrategy());
//    Screengrab.screenshot("before_button_click", (screenshotName, screenshotCallback) -> {
//      screenshotCallback.screenshotCaptured();
//      return;
//    });

    // Your custom onView...
//    onView(withId(R.id.fab)).perform(click());

    Screengrab.screenshot("after_button_click");
  }

//  @Test
//  public void testWikipediaJUnit4_test1() throws Exception {
//    driver.get(baseUrl + "/");
//    driver.findElement(By.id("searchInput")).clear();
//    driver.findElement(By.id("searchInput")).sendKeys("blueberries");
//    takeScreenShot("blueberry2.png");	// Capture screenshot of current state
//    driver.findElement(By.name("go")).click();
//    driver.findElement(By.cssSelector("p > i > a[title=\"Vaccinium\"]")).click();
//    takeScreenShot("vaccinium2.png");	// Capture screenshot of current state
//    driver.findElement(By.linkText("huckleberry")).click();
//    takeScreenShot("huckleberry2.png");	// Capture screenshot of current state
//  }
//
//  private void takeScreenShot(String fname) throws Exception {
//    File scrFile = ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
//    String imageFileDir = System.getProperty("selenium.screenshot.dir");
//    if (imageFileDir == null)
//      imageFileDir = System.getProperty("java.io.tmpdir");
//    FileUtils.copyFile(scrFile, new File(imageFileDir, fname));
//  }
}
