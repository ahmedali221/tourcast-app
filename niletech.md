# Tour Guide Mobile Application

### Phase 1 — Feature Documentation & Flutter Developer Handoff

```
Platform
Flutter (iOS & Android)
```
```
Phase
Phase 1 — Initial Release
```
```
Languages
English & Arabic (RTL supported)
```
```
Date
May 202 6
```

## 1. Overview & Phase Scope

This document defines Phase 1 of the NileTech Tour Guide mobile application. It covers every screen,
user flow, and interaction the Flutter developer must implement. The backend is a RESTful Laravel API
(Thoth Platform).

```
ℹ Phase 1 is the complete foundation of the application — authentication, identity verification, account
status management, the applications marketplace, earnings dashboard, and app settings.
```
#### ▌ Screens in This Phase

```
# Screen Route / Key
```
```
1 Registration & Identity Upload Onboarding
```
```
2 Pending Approval Screen Post-registration
```
```
3 Login Auth
```
```
4 Home — Applications Marketplace /api/guide/applications
```
```
5 Application Detail + WebView Config Per app
```
```
6 Earnings & Payout Dashboard Wallet / Commissions
```
```
7 Settings (Language + Payout Info) Profile settings
```
```
8 Support Tickets (List + Detail + Create) Ticketing system
```
```
9 Notification Inbox In-app notifications
```

## 2. Registration & Identity Verification

This is a single multi-step registration flow. The guide fills in personal information and uploads required
identity documents before submitting. The account is created in PENDING status and waits for admin
approval.

#### ▌ 2.1 Registration Form Fields

```
Field Type Required Notes
```
```
Full Name Text input Yes First and last name
```
```
Email Address Email input Yes Used for login
```
```
Mobile Number Phone input Yes With country code picker
```
```
Password Secure text Yes Min 8 characters
```
```
Password Confirmation Secure text Yes Must match password
```
```
National ID Photo Image upload Yes Front of national ID card
```
```
Guide License Photo / PDF File upload Yes Official tour guide license
```
```
Passport Number Text input Yes As on passport
```
```
National ID Number Text input Yes ID card number
```
```
Guide License Number Text input Yes License registration number
```
#### ▌ 2.2 File Upload Requirements

- **Format:** National ID Photo:
    - JPEG or PNG, max 2 MB
    - Display preview after selection
    - Allow re-selection before submitting
- **Format:** Guide License:
    - JPEG, PNG, or PDF, max 5 MB
    - Display thumbnail or filename after selection

```
ℹ All uploaded files are sent to the backend as multipart form data via the verification submission
endpoint. Store document URLs returned by the file upload step, then include them in the POST
/api/guide/verification body.
```

#### ▌ 2.3 API Sequence for Registration

#### 1

```
POST /api/register
Send name, email, mobile, password → receive Bearer token
```
#### 2

```
Upload documents
Send each file to the media/upload endpoint → receive document_urls array
```
#### 3

```
POST /api/guide/verification
Send passport_number, national_id, guide_license_number, document_urls
```
#### 4

```
Navigate to Pending Screen
Account is now PENDING — await admin approval
```
#### ▌ 2.4 Form Validation Rules

```
Field Validation Rule
```
```
Email Valid email format, unique (API returns error if duplicate)
```
```
Password Min 8 characters, must contain letters and numbers
```
```
Mobile Number Valid phone number format with country code
```
```
National ID Photo Required, image file, max 2 MB
```
```
Guide License Required, image or PDF, max 5 MB
```
```
All text fields Non-empty, trimmed whitespace
```
## 3. Account Status System

Every guide account has one of four statuses. The app must check status on login and after each app
resumes and route the user to the correct screen accordingly.

```
⏳
PENDING
```
```
New account awaiting admin review. Guide submitted documents but approval has not
been granted yet. Show the Pending Approval screen with a clear message and
estimated wait time.
```
```
✅
APPROVED
```
```
Accounts are verified and active. Guide has full access to the application:
marketplace, earnings, settings, and all features.
```

```
❌
REJECTED
```
```
Documents were rejected by the admin. Show rejection reason if available. Allow the
guide to re-upload corrected documents and resubmit.
```
```
🚫
SUSPENDED
```
```
Accounts have been suspended for policy violations. Guides cannot access any
features. Show a clear suspension notice with contact support option.
```
#### ▌ 3.1 Status Routing Logic

```
Status on Login Destination Screen Actions Available
```
```
PENDING Pending Approval Screen View status message only
```
```
APPROVED Home — Marketplace Full app access
```
```
REJECTED Rejection Screen Re-upload documents, resubmit
```
```
SUSPENDED Suspension Screen Contact support only
```
#### ▌ 3.2 Pending Approval Screen

```
⏳ Pending Approval
```
```
→ Large status icon and 'Under Review' heading
→ Message : Your documents have been submitted. Our team is reviewing your application.
→ Estimated review time (e.g. 1–3 business days)
→ Guide’s submitted name and email shown for confirmation
→ Contact support button (opens ticket creation)
→ Logout button
→ Auto - refresh status on app resume / pull-to-refresh
```
#### ▌ 3.3 Rejection Screen

```
❌ Account Rejected
```
```
→ Rejection reason displayed (from API response if available)
→ List of which documents were rejected
→ Re - upload button per document type
→ Resubmit button → calls POST /api/guide/verification again
→ Contact support link
```

#### ▌ 3.4 Suspension Screen

```
🚫 Account Suspended
```
```
→ Clear suspension notice with NileTech branding
→ Reason for suspension (if provided by API)
→ Contact support button → opens support ticket or email
→ No other navigation available
→ Logout button
```
## 4. Home Applications Marketplace

After a successful login with APPROVED status, the guide lands on the Home screen. This is a
marketplace-style list of all available NileTech applications.

#### ▌ 4.1 API

```
ℹ GET /api/guide/applications → Returns paginated list of available apps with their plans, plan type,
promo_plan_ids, and supports_promo_request flag.
```
#### ▌ 4.2 Applications List Screen

```
🏠 Home — Your Applications
```
```
→ Grid or card list of available apps
→ Each card shows: App icon, App name, Short description, Category/tag
→ Pull - to-refresh to reload app list
→ Empty state if no apps returned
→ Tap any card → navigate to Application Detail screen
```
#### ▌ 4.3 App Card UI Elements

```
Element Source Field Notes
```
```
App Icon icon_url Cached network image, fallback placeholder
```
```
App Name name Bold, max 2 lines
```
```
Short Description short_description Truncated to 2 lines with ellipsis
```
```
Category / Tag category Small badge chip
```
```
Status Indicator (if subscribed) 'Active' green dot or badge
```

## 5. Application Detail Screen

Tapping an app card opens the full detail page. This screen provides everything the guide needs to
understand the application and take action.

#### ▌ 5.1 Screen Layout & Content

```
📱 Application Detail
```
```
→ App icon + name + category badge at top
→ Demo video player (if demo_video_url available) — embedded video with play/pause
→ Full description section — rich text / markdown rendered
→ Features list — bullet points of key capabilities
→ Screenshots / preview images (horizontal scroll gallery)
→ Configure button → opens WebView configuration page
→ Open / Download button → links to App Store or Play Store
```
#### ▌ 5.2 Demo Video

- Only shown if demo_video_url is not null
- Use a native video player widget (video_player package)
- Show thumbnail with play button overlay before user taps
- Support pause, play, seek, fullscreen
- Autoplay muted is optional — do not autoplay with sound

#### ▌ 5.3 Configure Button — WebView

- Opens an in-app WebView (webview_flutter package)
- URL is the app's configuration_url from the API response
- The WebView allows the guide to set up their specific settings for that application
- Pass the Bearer token as an Authorization header in the WebView request
- Show a loading indicator while the WebView is loading
- Include a close / back button to return to the detail screen

```
ℹ The configuration page is app-specific and hosted by each product. The Flutter app only renders it
— no special handling needed beyond token injection.
```

#### ▌ 5.4 Open / Download Button

- Label logic:
    - If app is installed on device → label: 'Open App'
    - If app is not installed → label: 'Download on App Store' / 'Get on Google Play'
- Opens the store listing URL (store_url from API) using url_launcher
- On iOS → opens App Store; on Android → opens Play Store

#### ▌ 5.5 API Fields Expected from /api/guide/applications/{id}

```
Field Type Usage
```
```
id Integer Used in API calls
```
```
name String Display name
```
```
short_description String Card subtitle
```
```
description String / HTML Full detail body
```
```
icon_url URL App icon
```
```
demo_video_url URL / null Video player section
```
```
features Array of strings Features bullet list
```
```
screenshots Array of URLs Image gallery
```
```
configuration_url URL WebView target
```
```
store_url URL App Store / Play Store link
```
```
category String Badge chip
```

## 6. Earnings & Payout Dashboard

A dedicated screen showing the guide's financial summary — wallet balance, commissions earned, and
payout request functionality.

#### ▌ 6.1 Wallet Summary

```
💰 Earnings Dashboard
```
```
→ Current wallet balance (large, prominent display)
→ Currency label (from API)
→ Total commissions earned (lifetime)
→ Pending payout amount (if any)
→ Recent transactions list (last 5–10 entries)
→ View All Transactions button → paginated list screen
```
#### ▌ 6.2 API Endpoints for This Screen

```
Endpoint Purpose
```
```
GET /api/guide/wallet Balance, currency, recent transactions
```
```
GET /api/guide/commissions Paginated commissions list
```
```
GET /api/guide/payouts Paginated payout history
```
```
POST /api/guide/payouts Submit new payout request
```
#### ▌ 6.3 Payout Request

- Trigger: 'Request Payout' button on the earnings screen
- Show a bottom sheet or dialog with:
    - Amount field (numeric, max = available balance)
    - Payment method selector (populated from guide's saved payout info in Settings)
    - Confirm and Cancel buttons
- On confirm → POST /api/guide/payouts with {amount, payment_method}
- Show success confirmation and refresh wallet balance
- Show error message if API returns validation failure

#### ▌ 6.4 Transaction & Payout History

- Both lists are paginated — implement infinite scroll or 'Load More'
- Each transaction row shows date, description, amount (+ or –), status
- Each payout row shows date, amount, payment method, status


## 7. Settings Screen

The settings screen allows the guide to manage their payout information and application language
preference.

#### ▌ 7.1 Payout Information

- Section title: 'Payout Details'
- Fields the guide can enter and save:
    - Payment method type (e.g. Bank Transfer, Wallet)
    - Bank name (if bank transfer)
    - Account number / IBAN
    - Account holder name
- Save button → PATCH /api/guide/profile with payment info fields
- Show current saved values pre-filled on screen open

#### ▌ 7.2 Language Selection

- Two options: English (EN) and Arabic (AR)
- Display as toggle or segmented control
- Changing language:
    - Immediately switches app locale using Flutter Localizations
    - Arabic must apply RTL layout direction (Directionality widget)
    - Persists choice to local storage (shared_preferences)
    - PATCH /api/guide/profile with preferred_language field

```
ℹ All UI strings must have both EN and AR translations defined in the app's localization files. Use
Flutter's intl / ARB file approach.
```

## 8. App Footer — Social / Community

A persistent footer (or bottom navigation tab) includes a social community icon powered by the Octopus
SDK. In Phase 1 this shows a 'Coming Soon' experience.

#### ▌ 8.1-Footer Navigation

```
Tab Icon Phase 1 Behavior
```
```
Home Apps / Grid icon Active — opens Marketplace
```
```
Earnings Wallet icon Active — opens Earnings Dashboard
```
```
Support Ticket / Chat icon Active — opens Support Tickets list
```
```
Community Octopus / People icon Shows Coming Soon modal
```
```
Settings Gear icon Active — opens Settings
```
#### ▌ 8.2 Community Tab — Coming Soon

- Tapping the Community tab shows a modal or full-screen overlay
- Content:
    - Octopus community icon / illustration
    - Heading: 'Community — Coming Soon'
    - Sub-text: 'Connect with fellow guides, share experiences, and grow your network. Launching soon.'
    - Dismiss / OK button
- Do NOT initialize the Octopus SDK in Phase 1

```
ℹ The Octopus SDK (octopus-sdk-flutter — github.com/Octopus-Community/octopus-sdk-flutter) will
be integrated in a future phase. In Phase 1 only the awareness model is needed.
```

## 9. Support Ticketing System

The in-app ticketing system is the primary communication channel between guides and the NileTech
support team. Every guide can open, track, and reply to support tickets directly from the app.

#### ▌ 9.1 Ticket List Screen

```
🎫 My Support Tickets
```
```
→ Paginated list of all tickets submitted by this guide
→ Each row shows: subject, category, priority badge, status badge, last updated date
→ Pull - to-refresh to reload list
→ Empty state with 'Create your first ticket' prompt
→ Floating Action Button → opens Create Ticket screen
→ Tap any ticket row → opens Ticket Detail screen
```
#### ▌ 9.2 Create Ticket Screen

```
Field Type Options / Notes
```
```
Category Dropdown PAYMENT, TECHNICAL, ACCOUNT, GENERAL
```
```
Priority Segmented control NORMAL, HIGH, URGENT
```
```
Subject Text input Short summary, max 100 chars
```
```
Message Multi-line text area Initial message body, min 20 chars
```
- Submit button → POST /api/guide/support/tickets
- On success → navigate to the newly created Ticket Detail screen
- Show loading indicator during submission
- Validate all fields before enabling Submit

#### ▌ 9.3 Ticket Status Badges

```
Status Color Meaning
```
```
OPEN Blue Ticket submitted, awaiting first response
```
```
IN PROGRESS Yellow / Amber Support team is actively working on it
```
```
WAITING Orange Waiting for guide to reply
```
```
RESOLVED Green Issue has been resolved
```
```
CLOSED Gray Ticket closed — no further replies
```

#### ▌ 9.4 Ticket Detail & Reply Screen

```
💬 Ticket Conversation
```
```
→ Ticket subject and metadata (category, priority, status) at top
→ Chronological message thread — chat bubble style UI
→ Support messages aligned left (gray bubble), guide messages aligned right (navy bubble)
→ Timestamp shown under each message
→ Text input + Send button pinned to bottom of screen
→ Send → POST /api/guide/support/tickets/{id}/messages with {message}
→ Auto - scroll to bottom on open and after sending
→ Disable input field and show read-only notice if ticket is CLOSED
```
```
ℹ GET /api/guide/support/tickets/{id} returns the full ticket with message thread. Poll or use pull-to-
refresh for new replies. Push notification will trigger a refresh when a new reply arrives.
```
## 10. Push Notifications

Push notifications keep guides informed about ticket replies, account status changes, and platform
announcements. Device registration must happen immediately after login.

#### ▌ 10.1 Device Registration

- Call POST /api/guide/device immediately after successful login or registration
- Fields required:
    - device_id — unique device identifier (use device_info_plus package)
    - device_info — JSON object: {model, os_version, platform}
- Re-register on every app launch if token may have changed (FCM token refresh)
- Use Firebase Cloud Messaging (FCM) for both iOS and Android

#### ▌ 10.2 Notification Types

```
Notification Type Trigger Deep Link Destination
```
```
Ticket Reply Support team replies to a ticket Open Ticket Detail screen
```
```
Account Approved Admin approves the guide account Navigate to Home — Marketplace
```
```
Account Rejected Admin rejects verification documents Open Rejection Screen
```
```
Account Suspended Admin suspends the account Open Suspension Screen
```

```
New Announcement Platform-wide announcement published Open Announcements list
```
```
Payout Processed Payout request status updated Open Earnings Dashboard
```
#### ▌ 10.3 Handling Incoming Notifications

- App in foreground → show in-app banner / snackbar with action button
- App in background → system tray notification, tap to open app
- App terminated → system tray notification, tap launches app at correct screen
- All notifications must carry a data payload with:
    - type — notification type string (ticket_reply, account_approved, etc.)
    - entity_id — relevant ID (ticket ID, etc.) for deep linking

#### ▌ 10.4 Notification Inbox (In-App)

- GET /api/guide/notifications → paginated list of all notifications
- Show unread count badge on the notification bell icon in app bar
- Mark as read via query param: GET /api/guide/notifications?mark_read[]=1,2,
- Notification list screen:
    - Each row: icon by type, title, body preview, timestamp, read/unread indicator
    - Tap row → deep link to relevant screen and mark as read
    - 'Mark all as read' action in top bar

#### ▌ 10.5 Flutter Implementation Notes

- Package: firebase_messaging for FCM token and foreground/background handling
- Package: flutter_local_notifications for foreground in-app banners on Android
- Request notification permission on first launch (iOS requires explicit permission prompt)
- Handle onMessage, onMessageOpenedApp, and getInitialMessage callbacks
- Store FCM token and re-send to /api/guide/device on token refresh

```
ℹ iOS requires APNs configuration in Firebase Console and the correct entitlements in the Xcode
project. Android requires the google-services.json file in the app module.
```

## 11. Full Registration & Onboarding Flow

#### 1

```
Splash Screen
Logo animation → check stored token → route to Login or Home
```
#### 2

```
Login Screen
Email + password → POST /api/login → store token → check account status
```
#### 3

```
Status Check
APPROVED → Home | PENDING → Pending Screen | REJECTED → Rejection Screen |
SUSPENDED → Suspension Screen
```
#### 4

```
Registration (new user)
Multi-step form: Personal Info → Document Upload → Submit
```
#### 5

```
POST /api/register
Create account → receive token
```
#### 6

```
Upload Documents
Upload national ID photo + license → receive document_urls
```
#### 7

```
POST /api/guide/verification
Submit verification data with document_urls
```
#### 8

```
Pending Approval Screen
Wait for admin — auto-check on app resume
```
#### 9

```
Admin Approves → APPROVED
Next app opens status check passes → navigate to Home
```

## 12. Recommended Flutter Packages

```
Package Purpose
```
```
flutter_secure_storage Store Bearer token securely
```
```
http / dio API requests with auth interceptor
```
```
image_picker National ID and license photo selection
```
```
file_picker License PDF upload
```
```
webview_flutter In-app WebView for app configuration
```
```
video_player Demo video playback on app detail screen
```
```
url_launcher Open App Store / Play Store links
```
```
shared_preferences Persist language preference
```
```
cached_network_image App icons and screenshots
```
```
flutter_localizations + intl EN / AR localization + RTL support
```
```
firebase_messaging FCM push notifications (foreground + background)
```
```
flutter_local_notifications In-app notification banners (Android foreground)
```
```
device_info_plus Retrieve device_id and device_info for registration
```
```
octopus-sdk-flutter Phase 2 — Community tab (not used in Phase 1)
```
## 13. Out of Scope — Phase 1

```
Feature Phase
```
```
Community / Social (Octopus SDK) Phase 2
```
```
Promo Code Redemption Future phase
```
```
In-app Chat / Real-time messaging Future phase
```
```
Knowledge Center Future phase
```
```
In-app Subscription Purchase Future phase
```
```
NileTech for Technology Development • Tour Guide App — Phase 1 • Confidential
For questions contact the NileTech Product Team
```

