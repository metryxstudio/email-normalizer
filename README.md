# Email Address Normalizer

A Google Tag Manager variable template for both web and server containers that normalizes email addresses for server-side tracking by converting to lowercase, trimming whitespace, and applying Gmail-specific rules.

## Overview

This template prepares email addresses for hashing and sending to advertising platforms like Facebook CAPI, Google Ads, and TikTok. It handles Gmail-specific normalization rules that ensure consistent matching.

## Installation

1. In your GTM container (web or server-side), go to **Templates** → **Variable Templates** → **Search Gallery**
2. Search for "Email Address Normalizer"
3. Click **Add to workspace**

## Configuration

| Field | Description |
|-------|-------------|
| **Raw Email Address** | The email address in its original form |

## Examples

| Input | Output |
|-------|--------|
| ` User@Example.COM ` | `user@example.com` |
| `john.doe@gmail.com` | `johndoe@gmail.com` |
| `user+tag@gmail.com` | `user@gmail.com` |
| `John.Doe+newsletter@GMAIL.COM` | `johndoe@gmail.com` |
| `user@googlemail.com` | `user@gmail.com` |
| `john.doe+tag@outlook.com` | `john.doe+tag@outlook.com` |
| `invalidemail.com` | `undefined` |

## Features

- Converts to lowercase
- Trims leading and trailing whitespace
- **Gmail-specific normalization:**
  - Removes dots from local part (`john.doe` → `johndoe`)
  - Removes plus addressing (`user+tag` → `user`)
  - Normalizes `googlemail.com` to `gmail.com`
- Validates basic email format (must contain `@`)
- Returns `undefined` for invalid emails
- Non-Gmail addresses only get lowercase and trim treatment

## Why Gmail Normalization?

Gmail treats these as the same address:
- `johndoe@gmail.com`
- `john.doe@gmail.com`
- `j.o.h.n.d.o.e@gmail.com`
- `johndoe+newsletter@gmail.com`

Normalizing ensures consistent hashing for user matching across platforms.

## Usage Example

1. Create a variable using this template
2. Set **Raw Email Address** to your email data source (e.g., `{{Event Data - email}}`)
3. Use the normalized output in your tracking tags or hash it for CAPI

## Compatibility

This template works in both:
- **Web GTM** containers
- **Server-side GTM** containers

## Author

**Metryx Studio**  
Website: [metryx.studio](https://metryx.studio)  
Contact: filip@metryx.studio

## License

Apache License 2.0
