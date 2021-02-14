# VIT FLEX

This application takes your VIT timetable screenshot and then get your exact timetable. It will notify you at a set time before the class so that you can never forget to attend it.
A group of friends can join a team using the team code and the app can show the timings when everyone in that group is free so that they can hangout and do various stuff.

### Unique Selling Points

* Never miss any class or exam due to lack of attendance.
* Get sweet time to hangout with friends.
* Organise event, meeting in a fraction of a second.

## Implementation: 

## Technology Stack  

### Flutter

The app is implemented using flutter.

### Firebase

Used as a backend to run the python scripts. It will get the screenshot, processes it and send the final timetable back to the app.

### OpenCV

Preprocessing - blurring, edge detection, contrast boosting, color extraction.
Pytesseract OCR library for character recognition.

## Video

[Video](https://drive.google.com/file/d/1zt7jRDiPezX4ivarLWQPAGrw1pmHjbAT/view?usp=sharing)


## Prerequisites

VIT Email id, Screenshot of your timetable.


## Challanges

The OCR was trained on a different font, letters on the screenshot arn't exactly black making the extraction inaccurate. Thresholding, Canny edge detection, Image slicing arn't giving good results.

## Future Scope

Google Map integration: This functionality will let users see their team in realtime on google maps, and the app will suggest activities based on length of common free slots by taking travelling time, and staying time using google maps API.

## Authors
* [**Geeth**](https://github.com/GeethKuldeep) 
* [**Kanit**](https://github.com/kanitmann)
* [**Gauri**](https://github.com/kodekandy)
* [**Vamsi**](https://github.com/sairathnavamsi) 
