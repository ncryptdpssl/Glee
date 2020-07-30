import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:glee/musicWid//services/spotify_api.dart';
import 'package:glee/musicWid//utils/database_helper.dart';
import 'package:glee/musicWid//models/my_track.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  Map<String, dynamic> data = Map<String, String>();
  SpotifyHelper spotify = SpotifyHelper();
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // Scaffold Widget
    return Scaffold(
      // bg of the whole scaffold
      backgroundColor: Theme.of(context).backgroundColor,
      // Appbar
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
      ),
      // Main Body
      body: FutureBuilder(
        // get future data
        future: spotify.getTrackData(data['track_sId']),
        // building widget
        builder: (context, snapshot) {
          // If async await is completed
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              // padding
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              // Main column widget
              child: SingleChildScrollView(
                child: Column(
                  // Alignment such that it starts from left most
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Heading for track name
                    Text(
                      'TRACK NAME',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.black87,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // Track Name
                    Text(
                      snapshot.data.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Heading for duration
                    Text(
                      'DURATION (secs)',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.black87,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // Duration in secs
                    Text(
                      '${snapshot.data.durationMs / 1000}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Heading for Popularity
                    Text(
                      'POPULARITY',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // Popularity of the track
                    Text(
                      '${snapshot.data.popularity}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'ARTIST',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.black,
                        fontSize: 18.0,
                      )
                    ),
                    SizedBox(height: 10.0),
                    // ListView for all artists
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // shrink the builder to fit
                      shrinkWrap: true,
                      // number of artists in track
                      itemCount: snapshot.data.artists.length,
                      // Build widgets
                      itemBuilder: (context, index) {
                        return Column(
                          // Start from left to right
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Card for each artist
                            Text(
                              snapshot.data.artists[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                                letterSpacing: 2.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    // heading for album
                    Text(
                      'ALBUM',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // album
                    Card(
                      child: ListTile(
                        // album name
                        title: Text(
                          snapshot.data.album.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                        // Album Image
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Image.network(snapshot.data.album.images[snapshot.data.album.images.length - 1].url),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Button to take to spotify
                    RaisedButton(
                      child: Text(
                        'Open in Spotify',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2.0,
                        )
                      ),
                      // Color of button
                      color: Color(0xFF3bd6c6),
                      onPressed: () {
                        setState(() {
                          _launchURL(snapshot.data.externalUrls.spotify);
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // If code has error, throw it
            throw snapshot.error;
          } else {
            // Progress circle while async await is happening
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
      // FAB to save
      floatingActionButton: FloatingActionButton(
        // Plus icon
        child: Icon(Icons.add, color: Color(0xFF3bd6c6),),
        // bg color of the icon
        backgroundColor: Theme.of(context).accentColor,
        // tool tip when long pressed
        tooltip: 'Add to My Songs',
        // Save on press
        onPressed: () {
          if (data['onUserList'] == null) {
            _save(context, data['track_Name'], data['track_sId']);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // Save track to database
  _save(BuildContext context, String _name, String _sId) async {
    MyTrack _myTrack = MyTrack(_name, _sId);
    await helper.insertTrack(_myTrack);
  }

  // Function that launches an URL
  _launchURL(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

}
