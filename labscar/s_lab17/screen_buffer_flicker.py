import time
import os
import random

fan_frames = ['|', '/', '-', '\\']
frame_idx = 0

try:
    for tick in range(100):
        os.system('cls')  # Принудительная очистка экрана
        
        print("=== НИЗКОУРОВНЕВЫЙ МОНИТОР БУФЕРА ЭКРАНА (WINDOWS API) ===")
        print(f"Текущий кадр рендеринга: {tick:03d} / 100")
        
        current_data = random.randint(1100, 1600)
        print(f"Показания системного датчика: {current_data} ед.")
        
        current_frame = fan_frames[frame_idx]
        print(f"Статус кулера: [ {current_frame} ] ACTIVE")
        
        print("------------------------------------------------------------")
        
        frame_idx = (frame_idx + 1) % len(fan_frames)
        time.sleep(0.05)
except KeyboardInterrupt:
    pass