using FlutterUnityIntegration;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using TMPro;
using System.Globalization;

public class TestScript : MonoBehaviour
{
    [SerializeField] private float size = 1f;
    [SerializeField] private float rotationSpeed = 0f;

    public TMP_Text text;

    [SerializeField]
    private GameObject MainObject;

    void Start() {
        MainObject.transform.localScale = new Vector3(size, size, size);
    }

    void FixedUpdate() {
        MainObject.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime, Space.Self);
    }

    public float GetSize() {
        return this.size;
    }
    public void _SetSize(float size) {
        this.size = size;
        MainObject.transform.localScale = new Vector3(size, size, size);
    }

    public float GetRotationSpeed() {
        return this.rotationSpeed;
    }
    public void _SetRotationSpeed(float rotationSpeed) {
        this.rotationSpeed = rotationSpeed;
    }

    /*public void SetRotationSpeed(string message)
    {
        text.text = message;
        float value = float.Parse(message);
        _SetRotationSpeed(value);
    }*/
    public void SetRotationSpeed(string message)
    {
        //float value = float.Parse(message);
        float value = float.Parse(message, CultureInfo.InvariantCulture.NumberFormat);
        _SetRotationSpeed(value);
        //RotateAmount = new Vector3(value, value, value);
    }
    public void SetSize(string message)
    {
        float value = float.Parse(message, CultureInfo.InvariantCulture.NumberFormat);
        _SetSize(value);
    }

    public void CallBackFlutter()
    {
        Debug.Log("Sending log to Flutter: Teste flutter");
        UnityMessageManager.Instance.SendMessageToFlutter("Flutter");
    }

    public void IncreaseCubeSpeed() {
        _SetRotationSpeed(GetRotationSpeed() + 1);
        UnityMessageManager.Instance.SendMessageToFlutter(GetRotationSpeed().ToString());
    }
}
