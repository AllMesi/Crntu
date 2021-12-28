package misc;

import Sys.sleep;
import discord_rpc.DiscordRpc;

using StringTools;

class DiscordClient
{
  var clientID = "867307731458195457";
	public function new()
	{
		Crntu.log("Discord Client starting...");
		DiscordRpc.start({
			clientID: clientID,
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			// trace("Discord Client Update");
		}
    Crntu.log("Discord Client started on clientID " + clientID);

		DiscordRpc.shutdown();
	}

	public static function shutdown()
	{
		DiscordRpc.shutdown();
	}

	static function onReady()
	{
		#if debug
		DiscordRpc.presence({
			details: "Crntu | DEBUG MODE",
			state: null,
			largeImageKey: 'crntu',
			largeImageText: "Crntu"
		});
		#else
		DiscordRpc.presence({
			details: "Crntu",
			state: null,
			largeImageKey: 'crntu',
			largeImageText: "Crntu"
		});
		#end
	}

	static function onError(_code:Int, _message:String)
	{
		Crntu.log('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		Crntu.log('Disconnected! $_code : $_message');
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
	}

	public static function changePresence(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float)
	{
		var startTimestamp:Float = if (hasStartTimestamp) Date.now().getTime() else 0;

		if (endTimestamp > 0)
		{
			endTimestamp = startTimestamp + endTimestamp;
		}

		#if debug
		DiscordRpc.presence({
			details: details + "  | DEBUG MODE",
			state: state,
			largeImageKey: 'crntu',
			largeImageText: "Crntu",
			// smallImageKey : smallImageKey,
			// Obtained times are in milliseconds so they are divided so Discord can use it
			startTimestamp: Std.int(startTimestamp / 1000),
			endTimestamp: Std.int(endTimestamp / 1000)
		});
		#else
    DiscordRpc.presence({
			details: details,
			state: state,
			largeImageKey: 'crntu',
			largeImageText: "Crntu",
			// smallImageKey : smallImageKey,
			// Obtained times are in milliseconds so they are divided so Discord can use it
			startTimestamp: Std.int(startTimestamp / 1000),
			endTimestamp: Std.int(endTimestamp / 1000)
		});
		#end

		// trace('Discord RPC Updated. Arguments: $details, $state, $smallImageKey, $hasStartTimestamp, $endTimestamp');
	}
}
