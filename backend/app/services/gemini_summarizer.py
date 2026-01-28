import os
import google.generativeai as genai
from typing import List

# Placeholder for API Key. Ideally loaded from env.
# In a real scenario, we'll need to handle the case where the key is missing.
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

if GEMINI_API_KEY:
    genai.configure(api_key=GEMINI_API_KEY)

def generate_summary(text: str, title: str) -> List[str]:
    """
    Generates a 3-5 bullet point summary using Gemini.
    """
    if not GEMINI_API_KEY:
         return ["Summarization unavailable (Missing API Key).", "Please configure GEMINI_API_KEY."]

    model = genai.GenerativeModel('gemini-pro')
    
    prompt = f"""
    You are an expert research assistant for astronomy and aerospace engineering.
    Summarize the following scientific paper abstract into 3-5 concise, technical-but-readable bullet points.
    
    Paper Title: {title}
    Abstract: {text}
    
    Rules:
    1. Base all statements strictly on the provided abstract.
    2. Do not hallucinate or add outside information.
    3. Use clear, professional language suitable for a researcher.
    4. If citations are mentioned in the text, include them inline (e.g. [Author, Year] or [arXiv:ID]).
    5. Avoid hype or promotional language.
    
    Output strictly as a JSON list of strings, e.g. ["Point 1", "Point 2"].
    """
    
    try:
        response = model.generate_content(prompt)
        # Simple parsing if response is text; ideally request JSON mode or parse structure
        # For robustness, we will try to split lines if JSON fails or just clean up
        content = response.text
        
        # Basic cleanup to get a list
        import json
        import re
        
        # Try to find JSON list in the output
        match = re.search(r'\[.*\]', content, re.DOTALL)
        if match:
            return json.loads(match.group())
        else:
            # Fallback split
            lines = content.split('\n')
            return [line.strip('- *') for line in lines if line.strip()]
            
    except Exception as e:
        print(f"Error generating summary: {e}")
        return ["Error generating summary."]
