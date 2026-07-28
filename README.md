# project_azkar 

*By Ammar Ismail*

App name and icon still undecided.

## App features
* Show prayer times with local notifications using location and astronimical calculations instead of API.
* Show Hiri date and other information like Ramadan or other Islamic events.
* Morning/Night azkar + other azkar/duas like after prayer azkar, quran duas, etc..
* Show duas based on mood like specific duas for feeling sad, injustice, depressed, etc..
* Different prayer guides like how to pray in janazah, Isitkhara, etc..

## Tasks
### App configuration
- Increase color saturation across all app colors for phone screens.
- Check text theme if needed.
- Local notificaitons scheduling.
- Workmanager for app to work in background to schedule notifications.
- Check permissions for backround functionality and notifications.

### Home page
- Figure out prayer times (check the package you bookmarked and the ai chat you had).
- Hiri date (also package).
- Check fonts last time.

### Azkar page
- ~~Finish all azkar list data.~~
- ~~Make the top part of the azkar list page scrollable so it hides when scrolling down but shows up when scrolling again up using slivers.~~
- Figure out audio play, audio should be able to play, stop, autoplay all azkar, speed increase, every zekr played should be removed from list, and maybe have background play.
- ~~In azkar single page, finish card design.~~
- ~~In azkar completed page, make it so it calculates the sum of all azkar read with their count, and add a total of azkar read since the begining.~~
- Make a condition in DuaCard that if source is empty to hide the source button.
- Make the source and benefit dialog in DuaCard so when you click on it, it opens up a dialog with all the benefits of the azkar.
- ~~Maybe add animation for azkar single card, maybe a fade in animation, Maybe add ability to slide between the single cards and that could also work as the animation.~~
- ~~Figure out how to handle azkar when the counter could conflict with the logic, like for example when reading something that takes 1 count normally but 3 after other prayers. Maybe add conditions to cancel the counter ui and make the card dismiss with one tap instead of count.~~
- ~~Maybe add a hold gesture gesture to dismiss the card without having to get the count to 0, maybe add a size with shake animation with it and some haptics.~~

### Moods page
- Make the mood list top part as a sliver appbar or something like that, but make sure to keep the gradient background and make it scroll.
- Finish all mood supplications.

### Prayers page
- Finish working on the page.
- The carousel could use some work.
- Make a prayers model.
- Make the prayers list.
- Prayer details page should also use sliver. 

### Supplications page (Future work)
- Make the page and its data.

### Settings page
- Notifications settings like:
    - Prayer notifcations with delay (like 10 min before prayer starts or after it ends).
    - Morning/night azkar notification
    - General azkar throughout the day.
- Change font size(maybe 🤷).
- Change app theme (also maybe 🤷).
