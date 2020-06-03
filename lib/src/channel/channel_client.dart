import '../reverse_engineering/reverse_engineering.dart';
import '../videos/video_id.dart';
import 'channel.dart';
import 'channel_id.dart';
import 'username.dart';
import '../extensions/helpers_extension.dart';

/// Queries related to YouTube channels.
class ChannelClient {
  final YoutubeHttpClient _httpClient;

  /// Initializes an instance of [ChannelClient]
  ChannelClient(this._httpClient);

  /// Gets the metadata associated with the specified channel.
  Future<Channel> get(ChannelId id) async {
    var channelPage = await ChannelPage.get(_httpClient, id.value);

    return Channel(id, channelPage.channelTitle, channelPage.channelLogoUrl);
  }

  /// Gets the metadata associated with the channel of the specified user.
  Future<Channel> getByUsername(Username username) async {
    var channelPage =
        await ChannelPage.getByUsername(_httpClient, username.value);
    return Channel(ChannelId(channelPage.channelId), channelPage.channelTitle,
        channelPage.channelLogoUrl);
  }

  /// Gets the metadata associated with the channel
  /// that uploaded the specified video.
  Future<Channel> getByVideo(VideoId videoId) async {
    var videoInfoResponse =
        await VideoInfoResponse.get(_httpClient, videoId.value);
    var playerReponse = videoInfoResponse.playerResponse;

    var channelId = playerReponse.videoChannelId;
    return await get(ChannelId(channelId));
  }

  /// Enumerates videos uploaded by the specified channel.
  void getUploads(ChannelId id) async {
    var playlist = 'UU${id.value.substringAfter('UC')}';
    //TODO: Finish this after playlist
  }
}