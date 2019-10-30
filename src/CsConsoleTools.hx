package;

/**
 * Not very elegant at all!
 * Perhaps borrow wincon.dll from https://github.com/haxiomic/console.hx for non-C#?
 * @author YellowAfterlife
 */
@:classCode('
	private const int STD_OUTPUT_HANDLE = -11;
	private const uint ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004;

	[System.Runtime.InteropServices.DllImport("kernel32.dll")]
	static extern bool GetConsoleMode(System.IntPtr hConsoleHandle, out uint lpMode);

	[System.Runtime.InteropServices.DllImport("kernel32.dll")]
	static extern bool SetConsoleMode(System.IntPtr hConsoleHandle, uint dwMode);

	[System.Runtime.InteropServices.DllImport("kernel32.dll", SetLastError = true)]
	static extern System.IntPtr GetStdHandle(int nStdHandle);

	[System.Runtime.InteropServices.DllImport("kernel32.dll")]
	static extern uint GetLastError();
')
class CsConsoleTools {
	@:functionCode('
		var h = GetStdHandle(STD_OUTPUT_HANDLE);
		if (h == System.IntPtr.Zero) return false;
		uint m;
		return GetConsoleMode(h, out m)
			&& SetConsoleMode(h, m | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
	')
	public static function enableVTT() untyped {
		return false;
	}
}