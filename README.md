# Replay-Restarter-For-OBS

Restarts the replay buffer when saving a clip to prevent clip overlapping
![1 0 0-buffer](https://github.com/user-attachments/assets/aa9c3275-b730-4634-951e-40414e9b3459)

## Requirements

> ...that are necessary:
- [OBS Studio](https://obsproject.com/de/download)

## Setup

1. Download the lua file by clicking on `Replay-Restarter-For-OBS` and the download symbol next to `Raw`.
![1 0 0-file](https://github.com/user-attachments/assets/26a80734-4de7-478e-8735-6aa2038b2939)\
![1 0 0-download](https://github.com/user-attachments/assets/58cdfbe9-d311-4d14-a155-26d06fe2031c)
2. Move the file to a desired location.\
![1 0 0-desire](https://github.com/user-attachments/assets/6c8aae59-9ac5-4fc9-bdc7-1e37268da76c)
3. Head into OBS and `Tools` & `Scripts`.\
![1 0 0-scripts](https://github.com/user-attachments/assets/07f5feba-54df-4d7a-a0a5-3409582e9c39)
4. Click on the Plus (`+`) symbol on the left, navigate to the folders location and choose the lua script file (`Replay-Restarter-For-OBS`).\
![1 0 0-lua](https://github.com/user-attachments/assets/b49e911a-dda4-4077-b385-14d321e2f772)
5. (Optional) Change settings depending on your preferences.\
![1 0 0-options](https://github.com/user-attachments/assets/ff6ee01c-d4d2-48a5-bfda-4b1442c7baa0)

## Recommended timing based on own testing

> [!Note]
> This script requires a delay of at least half a second between each toggle where nothing is recorded.
> The values below may depend on your computers hard- and or software.

| Time in seconds | Recommendation                                                   |
| --------------- | ---------------------------------------------------------------- |
| 0.50 (lowest)   | risky, test this properly before using! This may not re-enable!  |
| 1.00            | fast, reliability may vary depending on your computers workload. |
| 1.50            | default, should work in all cases.                               |