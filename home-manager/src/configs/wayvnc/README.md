# Steps to Use Android Phone as a Second Monitor in Hyprland with Wayvnc (USB Connection)

This method creates a native virtual headless display in Hyprland, streams it using `wayvnc` over a USB cable, and captures it using a VNC app on Android.

---

## 1. Prerequisites & Tool Installation

### On Your Linux PC

Install the Android debugging tools and a Wayland-compatible VNC server:

```bash
# On Arch Linux
sudo pacman -S android-tools wayvnc jq
```

For NixOS just use ./default.nix.

### On Your Android Phone

1. **Enable USB Debugging:**
   - Go to **Settings > About Phone**.
   - Tap **Build Number** 7 times until Developer Mode is unlocked.
   - Go to **Settings > System > Developer Options** and toggle **USB Debugging** on.
2. **Install a VNC Client:**
   - Download a high-performance VNC viewer app such as **AVNC** (available on F-Droid / Google Play Store) or **bVNC**.

---

## 2. Configuration Steps

### Step 1: Create the Headless Monitor in Hyprland

Generate a virtual monitor dynamically within Hyprland:

```bash
hyprctl output create headless
```

To verify the exact name of the newly created display interface (usually `HEADLESS-1`), check your active displays:

```bash
hyprctl monitors
```

### Step 2: Position and Define the Resolution

Configure the resolution of the headless display and place it relative to your primary layout. Change `HEADLESS-1` if your display name differed in the step above:

```bash
# Example: 1920x1080 resolution, 60Hz, automatically positioned to the right of your main monitor
hyprctl keyword monitor HEADLESS-1,1920x1080@60,auto-right,1

# Optional: Force workspace 6 to open on this specific screen
hyprctl keyword workspace 6,monitor:HEADLESS-1
```

### Step 3: Run the VNC Server Targeted at the Virtual Output

Launch `wayvnc` bound specifically to the headless device instance:

```bash
wayvnc --output=HEADLESS-1 0.0.0.0 5900
```

_(Keep this terminal tab running; do not close it.)_

### Step 4: Map Port Forwarding Over USB (ADB)

Connect your Android phone to the PC via a USB cable. Open a new terminal window or tab and tunnel the VNC traffic into the phone:

```bash
adb reverse tcp:5900 tcp:5900
```

If prompted on your phone's screen, accept the signature authorization to allow USB debugging from your computer.

### Step 5: Connect from Your Android Device

1. Open your chosen VNC Client app (e.g., **AVNC**) on your phone.
2. Add a new configuration profile.
3. Set the Address/IP to **`127.0.0.1`** and the Port to **`5900`**.
4. Save and connect. Your phone will immediately render your second Linux workspace.

---

## 3. Disconnection & Cleanup

When you are done using the phone as a monitor, clean up the sessions to free resources:

1. Close the `wayvnc` terminal process with `Ctrl + C`.
2. Destroy the virtual layout instance to return your desktop setup to normal:

```bash
hyprctl output remove HEADLESS-1
```
