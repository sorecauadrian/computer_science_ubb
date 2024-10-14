# akashic dreams

## Lab Requirements
The lab plan can be found [here](http://www.cs.ubbcluj.ro/~dan/ma/labPlan.html).

### Non-Technical Overview
This is a mobile application dedicated to the ones that want to lucid dream and keep track of their dreams. The user should be able to check all the dreams he/she uploaded, add a new dream, delete an existing one and update the data of a dream.

On the main screen, the user should be able to check all the dreams he/she registered. There should also be a button that, if pressed,  takes the user to a different page, where he/she will be able to add a new dream to the record. When pressing on a list entry from the main page, the user will be prompted to a page where all the corresponding dream's details will be shown. Moreover, the user will have the possibility to update these details or delete the player.

### Problem Domain Overview
Entity that will be persisted: `Dream`<br />
Fields of the entity:

- `date:` datetime - the date of the dream (date + time)
- `title:` string - the title of the dream
- `description:` string - the description of the dream
- `rating:` integer - the rating (in stars, from 1 to 5) of the dream
- `lucidity:` bit - whether the user was lucid or not in his/her dream

### Actions - CRUD Operations
The following operations should be supported by the application:
- `create/add:` creates and adds a new dream to the record
- `read:` view the set of dreams that are currently in the record
- `update:` allow the user to update a dream found in the list. The user can update any fields of the dream
- `delete:` delete existing dreams from the list

### Persistence Details
All the available operations will be persisted on the local database and on the server (i.e., create/add, delete, update).

### Offline App Handling
The application should persist the content locally, to be able to allow offline access. While online, it should synchronize the content with a remote server. While offline the application will perform the following actions:

- on `update:` a message will be displayed, that the application is offline and the operation is not available
- on `delete:` a message will be displayed, that the application is offline and the operation is not available
- on `read:` the content from the local database will be displayed, with a note that the server connection is down
- on `create:` the input will be persisted in the local database and when the application will detect that the device is able to connect again to the server it will push only the created entries, while the device was offline

### App Mockup
You can check the initially proposed design of the app [here](https://www.figma.com/design/8emTbltWzUSrTSlG3PhXBp/MA_lab1?node-id=0-1&t=4QC3GNErM0uDcebT-1).

#### Main Page
![image](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester5/mobile_application_programming/lab/lab1/app_design/main.png)

#### Edit Page
![image](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester5/mobile_application_programming/lab/lab1/app_design/edit.png)
