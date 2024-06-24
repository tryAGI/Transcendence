using CommunityToolkit.Maui;

namespace Transcendence;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
#if !MACCATALYST
			.UseSentry(options => {
				options.Dsn = "https://8998baa8eb04ad6d835abc7a8f8638c2@o4504701907435520.ingest.us.sentry.io/4507488165167104";

#if DEBUG
				options.Debug = true;
#endif
				options.TracesSampleRate = 1.0;
				options.ProfilesSampleRate = 1.0;
			})
#endif
			.UseMauiCommunityToolkit()
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
			});

		builder.Logging
			.AddSentry(options => {
				options.Dsn = "https://8998baa8eb04ad6d835abc7a8f8638c2@o4504701907435520.ingest.us.sentry.io/4507488165167104";
			})
#if DEBUG
			.AddDebug()
			.AddConsole()
#endif
			;

		var app = builder.Build();

		Ioc.Default.ConfigureServices(app.Services);
		
		return app;
	}
}
