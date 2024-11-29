# OBS-Buffer-Clear
Restarts the replay buffer when saving a clip to prevent clip overlapping

## Requirements
> ...that are necessary:
- [OBS Studio](https://obsproject.com/de/download)

## Setup
1. Download the source code by clicking on `<> Code` & `Download ZIP` and extract its content\
![download](https://github.com/user-attachments/assets/ec352d75-4ffe-4c5a-b06a-2eea52df8bba)
2. Move the folder to a desired location
3. Head into OBS and `Tools` & `Scripts`
4. Click on the Plus (`+`) symbol on the left and navigate to the folders location
5. Choose the lua script file (`OBS-Buffer-Clear.lua`)
6. (Optional) change settings depending on your preferences

## Recommended timing based on own testing
> [!Note]
> This script requires a delay of at least half a second between each toggle where nothing is recorded.
> The values below may depend on your computers hardware- and or software.

| Time in seconds | Recommendation |
| --- | --- |
| 0.50 (lowest) | risky, test this properly before using! This may not re-enable depending on your computers tasks! |
| 1.00 | fast, reliability may vary depending on your computers workload. |
| 1.50 | default, should work in all cases. |